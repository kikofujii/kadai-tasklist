class TasksController < ApplicationController
    
    before_action :require_user_logged_in
    before_action :correct_user, only: [:destroy, :update, :edit, :show]
    
    def index
        if logged_in?
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
        end
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        if @task.save
            flash[:success] = "Taskが正常に登録されました"
            redirect_to @task
        else
            flash.now[:danger] = "Taskが登録出来ていません"
            render :new
        end
    end
    
    def new
        @task = Task.new
    end
    
    def edit
    end
    
    def show
       
    end
    
    def update
        if @task.update(task_params)
            flash[:saccess] = 'Taskが正常に編集されました'
            redirect_to @task
        else
            flash.now[:danger] = 'Taskが編集出来ていません'
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = "Taskは削除されました"
        redirect_to tasks_url
    end
    
    private
    def set_task
        @task = Task.find(params[:id])
    end
    
    def task_params
        params.require(:task).permit(:content,:status, :user)
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end
    end
end
