class HomeController < ApplicationController
  def index
		@tasks = current_user.tasks
		@my_tasks = @tasks.where("my_tasks.progress = :zero OR my_tasks.progress = :nothing", zero: 0, nothing: nil)
		@done_tasks = @tasks.where("my_tasks.progress = ? ", 1)
		@approved_tasks = @tasks.where("my_tasks.progress = ? ", 2)
		@random_tasks = Task.where(publicity: 1, status: 1).where.not(id: current_user.tasks).limit(5).order("RANDOM()")
		@my_score = current_user.score


		if current_user.role == "admin"
      @families = Family.all
      @houses = House.all
      @tasks_to_approve = []
      @users_with_unapproved_tasks = []
      @houses.each_with_index do |house, index|
        @tasks_to_approve << Task.joins(:my_tasks).where(my_tasks: {user_id: house.users.ids}).where(my_tasks: {progress: 1}).ids
        @tasks_to_approve[index].each do |task|
          @users_with_unapproved_tasks << [task, house.users.joins(:my_tasks).where(my_tasks: {progress: 1, task_id: task}).ids]
        end
      end
      @users_with_unapproved_tasks.uniq!
      @general_tasks = Task.where(publicity: 1, status: 1).limit(10).order("RANDOM()")
    else
      @families = current_user.families
      @houses = current_user.houses
    end
			# case current_user.role
			# when "House"
			# 	@houses = current_user.houses
			# when "Family"
			# 	@families = current_user.families
			# 	@houses = @families.map { |b| b.houses }.flatten
			# when "Region"
			# 	@regions = current_user.regions
			# 	@families = @regions.map { |r| r.families}.flatten
			# 	@houses = @families.map { |b| b.houses }.flatten
			# when "Movement"
			# 	@movements = current_user.movements
			# 	@regions = @movements.map { |m| m.regions }.flatten
			# 	@families = @regions.map { |r| r.families}.flatten
			# 	@houses = @families.map { |b| b.houses }.flatten
      # when "Admin"
      #   @movements = Movement.all
      #   @regions = Region.all
      #   @families = Family.all
      #   @houses = House.all
			# end
	end


	def leaders
		@regions = Region.all.order("score DESC")
		if params[:all] == "true"
			@families = Family.all.order("score DESC")
			@houses = House.all.order("score DESC")
		else
			case current_user.role
			when "House", "Kid"
				@families = current_user.houses.map{|g| g.region.families }.uniq.flatten.sort_by(&:score).reverse
				@houses = current_user.houses.map{|g| g.family.houses}.uniq.flatten.sort_by(&:score).reverse
			when "Family"
				@families = current_user.families.map{|g| g.region.families}.uniq.flatten.sort_by(&:score).reverse
				@houses = @families.map { |b| b.houses }.uniq.flatten.sort_by(&:score).reverse
			when "Region"
				@families = current_user.regions.map { |r| r.families}.flatten.uniq.sort_by(&:score).reverse
				@houses = @families.map { |b| b.houses }.flatten.uniq.sort_by(&:score).reverse
			when "Movement"
				@families = Family.all.order("score DESC")
				@houses = House.all.order("score DESC")
			end
		end
	end

	def pinkasi
	end


  def kid_guide
    MyHouse.create(user_id: current_user.id, role: "kid", my_houseable_id: params[:g], my_houseable_type: "House") unless current_user.houses.ids.include?(params[:g])
    redirect_to root_path
  end

end
