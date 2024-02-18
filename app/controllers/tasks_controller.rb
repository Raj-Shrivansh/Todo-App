class TasksController < ApplicationController
    def index
        if user_signed_in?
            @tasks=Task.where(:user_id => current_user.id).order("created_at DESC")
    end
end
    def show
        @task=Task.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        flash[:notice]="With given Id no record found!!"
        redirect_to root_path
    end
    def new
        @task=current_user.task.build
    end
    def create
        @task=current_user.task.build(tasks_params)
        if @task.save
            flash[:notice]="Task created Successfully"
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity
        end
    end
    def edit
        @task=Task.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            redirect_to root_path
        end
    def update
        @task=Task.find(params[:id])
        if @task.update(tasks_params)
            flash[:notice]="Task Updated Successfully"
            redirect_to  task_path(@task)
        else
            render :edit, status: :unprocessable_entity
        end
    end
    def destroy
        @task=Task.find(params[:id])
        @task.delete
        flash[:notice]="Task Removed Successfully"
        redirect_to root_path
        rescue ActiveRecord::RecordNotFound
            flash[:notice]="Task Removed Successfully"
            redirect_to root_path
        end
    def complete
        @task=Task.find(params[:id])
        @task.update_attribute(:completed_at,Time.now)
        flash[:notice]="#{@task.title} completed. Great Job!"
        redirect_to root_path
    end
    private
        def tasks_params
            params.required(:task).permit(:title,:desc)
        end
end
