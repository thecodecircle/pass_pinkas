class HomeController < ApplicationController
  def index
		@my_tasks = current_user.tasks.all
		@random_tasks = Task.limit(5).order("RANDOM()")
  end
end
