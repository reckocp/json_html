class TasksController < ApplicationController
  def index
    if request[:format] == "json"
      render App.tasks.to_json, status: "200 OK"
    else
      @tasks = App.tasks
      render_template 'tasks/index.html.erb'
    end
  end

  def show
    task = find_task_by_id

    if task
      if request[:format] == "json"
        render task.to_json
      else
        @task = task
        render_template 'tasks/show.html.erb'
      end
    else
      render_not_found
    end
  end

  def new
    render_template 'tasks/new.html.erb'
  end

  def create
    last_task = App.tasks.max_by { |task| task.id }
    new_id = last_task.id + 1

    App.tasks.push(
      Task.new(new_id, params["body"], false)
    )
    puts App.tasks.to_json

    render({ message: "Successfully created!", id: new_id }.to_json)
  end

  def update
    task = find_task_by_id
    if task
      unless params["body"].nil? || params["body"].empty?
        task.body = params["body"]
      end

      render task.to_json, status: "200 OK"
    else
      render_not_found
    end
  end

  def destroy
    task = find_task_by_id

    if task
      App.tasks.delete(task)
      render({ message: "Successfully Deleted Task" }.to_json)
    else
      render_not_found
    end
  end

  private
  def find_task_by_id
    App.tasks.find { |t| t.id == params[:id].to_i}
  end

  def render_not_found
    return_message = {
      message: "Task not found!",
      status: "404"
    }.to_json

    render return_message, status: "404 NOT FOUND!"
  end
end
