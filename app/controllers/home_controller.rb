class HomeController < ApplicationController
  def index
		@tasks = current_user.tasks
		@my_tasks = @tasks.where("my_tasks.progress = :zero OR my_tasks.progress = :nothing", zero: 0, nothing: nil)
		@done_tasks = @tasks.where("my_tasks.progress = ? ", 1)
		@approved_tasks = @tasks.where("my_tasks.progress = ? ", 2)
		@random_tasks = Task.where(publicity: 1, status: 1).where.not(id: current_user.tasks).limit(5).order("RANDOM()")
		@my_score = current_user.score
		if current_user.role != "Kid"
			case current_user.role
			when "Group"
				@groups = current_user.groups
			when "Branch"
				@branches = current_user.branches
				@groups = @branches.map { |b| b.groups }.flatten
			when "Region"
				@regions = current_user.regions
				@branches = @regions.map { |r| r.branches}.flatten
				@groups = @branches.map { |b| b.groups }.flatten
			when "Movement"
				@movements = current_user.movements
				@regions = @movements.map { |m| m.regions }.flatten
				@branches = @regions.map { |r| r.branches}.flatten
				@groups = @branches.map { |b| b.groups }.flatten
      when "Admin"
        @movements = Movement.all
        @regions = Region.all
        @branches = Branch.all
        @groups = Group.all
			end
			@tasks_to_approve = []
			@kids_with_unapproved_tasks = []
			@groups.each_with_index do |group, index|
				@tasks_to_approve << Task.joins(:my_tasks).where(my_tasks: {user_id: group.kids.ids}).where(my_tasks: {progress: 1}).ids
				@tasks_to_approve[index].each do |task|
					@kids_with_unapproved_tasks << [task, group.kids.joins(:my_tasks).where(my_tasks: {progress: 1, task_id: task}).ids]
				end
			end
			@kids_with_unapproved_tasks.uniq!
			@general_tasks = Task.where(publicity: 1, status: 1).limit(10).order("RANDOM()")
		end
	end


	def leaders
		@regions = Region.all.order("score DESC")
		if params[:all] == "true"
			@branches = Branch.all.order("score DESC")
			@groups = Group.all.order("score DESC")
		else
			case current_user.role
			when "Group", "Kid"
				@branches = current_user.groups.map{|g| g.region.branches }.uniq.flatten.sort_by(&:score).reverse
				@groups = current_user.groups.map{|g| g.branch.groups}.uniq.flatten.sort_by(&:score).reverse
			when "Branch"
				@branches = current_user.branches.map{|g| g.region.branches}.uniq.flatten.sort_by(&:score).reverse
				@groups = @branches.map { |b| b.groups }.uniq.flatten.sort_by(&:score).reverse
			when "Region"
				@branches = current_user.regions.map { |r| r.branches}.flatten.uniq.sort_by(&:score).reverse
				@groups = @branches.map { |b| b.groups }.flatten.uniq.sort_by(&:score).reverse
			when "Movement"
				@branches = Branch.all.order("score DESC")
				@groups = Group.all.order("score DESC")
			end
		end
	end

  def assign_task
    @task = Task.find(params[:task])
    if params[:group].present?
      @group = Group.find(params[:group])
      @group.kids.each do |k|
        k.tasks << @task if k.tasks.exclude?(@task)
      end
    else
      current_user.tasks << @task if current_user.tasks.exclude?(@task)
    end
    redirect_to root_path
  end

  def change_progress
    puts "****************************************"
    puts "Change Progress"
    if params[:kid_id].present?
      kid = User.find(params[:kid_id])
      my_task = kid.my_tasks.find_by(task_id: params[:task_id])
      puts "kid: #{my_task.user.name}"
      puts "task: #{my_task.task.name} from #{my_task.progress}"
      my_task.progress = "approved"
      kid.update(score: kid.score + my_task.task.score)
      kid.groups.where("my_groups.role = 0").each do |g|
        g.update(score: g.score + my_task.task.score)
        g.branch.update(score: g.branch.score + my_task.task.score)
        g.branch.region.update(score: g.branch.region.score + my_task.task.score)
        # g.branch.region.movement.update(score: g.branch.region.movement.score + my_task.task.score)
      end
    else
      my_task = current_user.my_tasks.find_by(task_id: params[:task_id])
      puts "task: #{my_task.task.name} from #{my_task.progress}"
      my_task.progress = "done"
    end
    my_task.save
    puts "to #{my_task.progress}"
    redirect_to root_path
  end

  def approve_task
    Task.find(params[:task_id]).approved!
    redirect_to tasks_path
  end

  def kid_guide
    MyGroup.create(user_id: current_user.id, role: "kid", my_groupable_id: params[:g], my_groupable_type: "Group")
    redirect_to root_path
  end

end
