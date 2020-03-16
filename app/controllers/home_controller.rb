class HomeController < ApplicationController
  def index
		@my_tasks = current_user.tasks.all
		@random_tasks = Task.where(publicity: 1, status: 1).left_outer_joins(:my_tasks).where( my_tasks: { id: nil } ).limit(5).order("RANDOM()")
		@done_tasks = @my_tasks.where("my_tasks.progress = ? ", 1)
		@approved_tasks = @my_tasks.where("my_tasks.progress = ? ", 2)
  end
end
