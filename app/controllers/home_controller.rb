class HomeController < ApplicationController
  def index

		if current_user.admin?
      @families = Family.all
      @houses = House.all
    else
      @families = current_user.families
      @houses = current_user.houses
    end
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


  def add_user_to_house
    current_user.houses << House.find(params[:h]) unless current_user.houses.ids.include?(params[:h])
    redirect_to root_path
  end

end
