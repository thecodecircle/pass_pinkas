class HomeController < ApplicationController
  def index

		if current_user.admin?
      @families = Family.all
      @houses = House.all
    else
      @houses = current_user.houses
			if params[:house].present?
				cookies[:house] = { value: params[:house], expires: Time.now + 36000000}
			else
				cookies[:house] = { value: @houses.first.id, expires: Time.now + 36000000} unless cookies[:house].present?
			end
			@house = House.find(cookies[:house])
			@family = @house.family
    end
	end


	def leaders
		if current_user.admin?
			@families = Family.all
			@houses = House.all
		else
			@families = current_user.families
			# @houses = @families.map { |f| f.houses }.flatten.uniq.sort_by(&:score).reverse
		end
	end

	def pinkasi
	end


  def add_user_to_house
    current_user.houses << House.find(params[:h]) unless current_user.houses.ids.include?(params[:h])
    redirect_to root_path
  end

end
