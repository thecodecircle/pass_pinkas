class HomeController < ApplicationController
  def index
		@tasks = current_user.tasks.all
		@my_tasks = @tasks.where("my_tasks.progress = :zero OR my_tasks.progress = :nothing", zero: 0, nothing: nil)
		@done_tasks = @tasks.where("my_tasks.progress = ? ", 1)
		@approved_tasks = @tasks.where("my_tasks.progress = ? ", 2)
		@random_tasks = Task.where(publicity: 1, status: 1).left_outer_joins(:my_tasks).where( my_tasks: { id: nil } ).limit(5).order("RANDOM()")
		@my_score = current_user.score
		if current_user.role == "Group"
			@groups = current_user.groups
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
end
