class HomeController < ApplicationController
  def index

		if current_user.admin?
      @families = Family.all
      @houses = House.all
      @house = @houses.first
      @family = @house.family
    else
      @houses = current_user.houses
			if params[:house].present?
				cookies[:house] = { value: params[:house], expires: Time.now + 36000000}
			else
				cookies[:house] = { value: @houses.first.id, expires: Time.now + 36000000} unless cookies[:house].present?
			end
      cookies[:house] = { value: @houses.first.id, expires: Time.now + 36000000} if cookies[:house].present? && @houses.exclude?(House.find(cookies[:house]))
			@house = House.find(cookies[:house])
			@family = @house.family
    end
	end

	def leaders
		if current_user.admin?
			@families = Family.all
			@houses = House.all
			@house = House.first
		else
			@house = House.find(cookies[:house])
			@families = current_user.families
			# @houses = @families.map { |f| f.houses }.flatten.uniq.sort_by(&:score).reverse
		end
	end


	def choose_house
		@families = current_user.families.uniq
	  @houses = @families.map { |f| f.houses }.flatten
	end
	def choose_task
	  @tasks = Task.where(publicity: 1, lang: current_user.locale)
	end

  def add_user_to_house
    current_user.houses << House.find(params[:h]) unless current_user.houses.ids.include?(params[:h])
    redirect_to root_path
  end

end
