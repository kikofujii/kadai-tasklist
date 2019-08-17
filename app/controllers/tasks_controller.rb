class TasksController < ApplicationController
    before_action :set_task, only: [:edit, :show, :update, :destroy]
    
    def index
        @tasks = Task.all
    end
    
    def create
        @task = Task.new(task_params)
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
        if @task.save
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
        params.require(:task).permit(:content)
    end
    
end
