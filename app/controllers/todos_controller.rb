# todo_items_conntroller.rb
class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render "index"
  end

  def show
    idno = params[:idno]
    todo_item = Todo.find(idno)
    render plain: todo_item.to_pleasant_string
  end

  def create
    todo_item_text = params[:todo_item_text]
    due_date = DateTime.parse(params[:due_date])
    new_todo_item = Todo.create!(todo_item_text: todo_item_text, due_date: due_date, completed: false)
    response_text = "Hey, your new todo_item is created with the idno #{new_todo_item.idno}"
    render plain: response_text
  end

  def update
    completed = params[:completed]
    idno = params[:idno]
    todo_item = Todo.find(idno)
    todo_item.completed = completed
    todo_item.save!
    render plain: "Updated todo_item completed status to #{completed}"
  end
end
