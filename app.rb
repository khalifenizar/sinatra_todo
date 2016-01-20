require "sinatra"
require "sinatra/reloader"

require_relative("lib/task.rb")
require_relative("lib/todo_list.rb")

todo_list = TodoList.new("Izzy")

get "/tasks" do
  @tasks = todo_list.tasks
  erb(:task_index)
end

get "/new_task" do
  erb(:new_task)
end

post "/create_task" do
  task = Task.new(params[:content])

  todo_list.add_task(task)
  todo_list.save
  redirect to("/tasks")
end

get "/complete_task/:id" do
  task = todo_list.find_task_by_id(params[:id])
  task.complete!
  todo_list.save

  redirect to("/tasks")
end

post "/delete_task" do
  todo_list.delete_task(params[:id])
  todo_list.save

  redirect to("/tasks")
end
