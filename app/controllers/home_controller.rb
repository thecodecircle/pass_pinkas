class HomeController < ApplicationController
  def index
		@tasks = current_user.tasks
		@my_tasks = @tasks.where("my_tasks.progress = :zero OR my_tasks.progress = :nothing", zero: 0, nothing: nil)
		@done_tasks = @tasks.where("my_tasks.progress = ? ", 1)
		@random_tasks = Task.where(publicity: 1, status: 1).where.not(id: current_user.tasks).limit(5).order("RANDOM()")
		@my_score = current_user.score
		@suggested_tasks = Task.where(publicity: 0).where.not(id: current_user.tasks)

		if current_user.admin?
      @families = Family.all
      @houses = House.all
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
		if current_user.admin?
			@families = Family.all
			@houses = House.all
		else
			@families = current_user.families
			@houses = @families.map { |f| f.houses }.flatten.uniq.sort_by(&:score).reverse
		end
	end

	def pinkasi
	end


  def kid_guide
    MyHouse.create(user_id: current_user.id, role: "kid", my_houseable_id: params[:g], my_houseable_type: "House") unless current_user.houses.ids.include?(params[:g])
    redirect_to root_path
  end

end
