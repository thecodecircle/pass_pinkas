class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    if %w(Admin Movement).include?(current_user.role)
      @tasks = Task.all
    else
      @tasks = Task.all.where(publicity: 1, status: 1)
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
        if params[:private_group_id].present? && @task.personal?
          format.html {
            puts "Guide wants personal task"
            puts "before - task is: #{@task.status}"
            @task.approved!
            puts "after - task is: #{@task.status}"
            redirect_to assign_task_path(task: @task.id, group: params[:private_group_id])
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
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def assign_task
    @task = Task.find(params[:task])
    if params[:group].present?
      @group = Group.find(params[:group])
      @group.kids.each do |k|
        k.tasks << @task if k.tasks.exclude?(@task)
      end
      @task.approved!
    else
      current_user.tasks << @task if current_user.tasks.exclude?(@task)
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
