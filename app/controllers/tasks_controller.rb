class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action do
    unless %w(new create).include?(action_name)
      redirect_to new_user_session_path unless current_user && current_user.admin?
    end
  end

  # GET /tasks
  # GET /tasks.json
  def index
    if current_user.admin?
      @tasks = Task.all
    else
      @tasks = Task.all.where(publicity: 1)
			@house = House.find(params[:house_id]) if params[:house_id].present?
			@family = House.find(params[:family_id]) if params[:family_id].present?
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.suggested_id = params[:suggested_id]
    respond_to do |format|
      if @task.save
        puts "****************************************"
        puts "task: #{@task.id}"
        if params[:house_id].present? && @task.personal?
					puts "a new task"
					puts House.find(params[:house_id]).name
          format.html {
            redirect_to assign_task_path(task: @task.id, house: params[:house_id])
          }
				elsif params[:family_id].present? && @task.personal?
						puts "a new task"
						puts Family.find(params[:family_id]).name
	          format.html {
	            redirect_to assign_task_path(task: @task.id, family: params[:family_id])
	          }
        else
          format.html { redirect_to root_path }
          format.json { render :show, status: :created, location: @task }
        end
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to root_path }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
			if current_user.admin?
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
			format.json { head :no_content }
			else
				format.html { redirect_to root_path }
			end
    end
  end

  def assign_task
    @task = Task.find(params[:task])
		if params[:house].present?
			@house = House.find(params[:house])
			@house.tasks << @task if @house.tasks.exclude?(@task)
		elsif params[:family].present?
			@family = Family.find(params[:family])
			@family.houses.each do |house|
				house.tasks << @task if house.tasks.exclude?(@task)
			end
		end
    redirect_to root_path
  end

  def change_progress
    puts "****************************************"
    puts "Change Progress"
			house = House.find(params[:house])
      puts "House: #{house.name}"
      puts "task_id: #{params[:task_id]}"
			my_task = house.my_tasks.find_by(task_id: params[:task_id])
			if params[:remove].present?
				my_task.destroy if my_task.present?
			else
				house.update(score: house.score + my_task.task.score)
				puts "task: #{my_task.task.name} from #{my_task.progress}"
				my_task.done!
        puts "to #{my_task.progress}"
			end
    redirect_to root_path
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :score, :description, :publicity, :status, :difficulty, :age)
    end
end
