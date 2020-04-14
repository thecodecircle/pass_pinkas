class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action do
    unless %w(new create assign_task change_progress).include?(action_name)
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
			if @house.tasks.exclude?(@task)
        @house.tasks << @task
        # require 'fcm'

        # fcm = FCM.new("AAAAhx0k54s:APA91bFpfLtMkJr_Z69jhGr8cW7HTNJBgiHPNjykSxmL96uLUSIf47SjHchPKhP59ChqXZDy7peD52j-PfNF4qAEC2x45-IKSJXkCL88RC6UYSvggoe1b9YHqCIgKLBkvflGh9CJv4wg")
        # you can set option parameters in here
        #  - all options are pass to HTTParty method arguments
        #  - ref: https://github.com/jnunemaker/httparty/blob/master/lib/httparty.rb#L29-L60
        #  fcm = FCM.new("my_server_key", timeout: 3)

        # registration_ids = ["dnJq1KM6pmHbaz7GxI6P7x:APA91bH0Ssg2_rY0avHUbbiEYGx87jKUMyLHXJogXfMmbTVZ64LhgO5OSJxD2nXM5CiGXQpunGsv-45c4rLyE2O1_FtRsM90BoIDL2KxQUWazzE4f-SPH9kjSO9tRORBsELPqp-2cf4N"] # an array of one or more client registration tokens
        # puts "************** FCM **************************"
        # See https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages for all available options.
        # options = { "notification": {
            # "title": "Portugal vs. Denmark",
            # "body": "5 to 1"
          # }
        # }
        # response = fcm.send(registration_ids, options)
        @house.users.each do |user|
          NotificationChannel.broadcast_to(user, ["#{current_user.name} איתגר אותך באתגר #{@task.name}", "#{view_context.image_url('logo.png')}", "#{view_context.image_url('badge-32.png')}", "#{view_context.asset_url('just')}"])
          puts "********************  Notification to #{user.name} ********************"
        end
      else
        NotificationChannel.broadcast_to(current_user, "ל#{@house.name} כבר יש את המשימה הזאת")
        puts "********************  Notification to #{current_user.name} ********************"
      end
      # ActionCable.server.broadcast('notification_channel', "The task #{@task.name} had been assigned to #{@house.name}")
        # NotificationChannel.broadcast_to(user, { notification: 'Test message' })
      # NotificationChannel.broadcast_to(@house.users.first, { notification: "The task #{@task.name} had been assigned to #{@house.name}" })
		elsif params[:family].present?
			@family = Family.find(params[:family])
			@family.houses.each do |house|
				if house.tasks.exclude?(@task)
          house.tasks << @task
          house.users.each do |user|
            NotificationChannel.broadcast_to(user, "#{current_user.name} איתגר אותך באתגר #{@task.name}")
            puts "********************  Notification to #{user.name} ********************"
          end
        end
			end
      # ActionCable.server.broadcast('notification_channel', "The task #{@task.name} had been assigned to #{@family.name}")
      # NotificationChannel.broadcast_to(@family.users.first, { notification: "The task #{@task.name} had been assigned to #{@family.name}" })
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
