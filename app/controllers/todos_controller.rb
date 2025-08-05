class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy, :toggle_complete]

  def index
    @todos = Todo.order(:priority, :created_at)
    @pending_todos = @todos.pending
    @completed_todos = @todos.completed
  end

  def show
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      redirect_to todos_path, notice: 'Todo was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @todo.update(todo_params)
      redirect_to todos_path, notice: 'Todo was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_path, notice: 'Todo was successfully deleted.'
  end

  def toggle_complete
    @todo.toggle_complete!
    status_message = @todo.completed? ? "✅ Todo '#{@todo.title}' completed! Well done!" : "📝 Todo '#{@todo.title}' reopened."
    redirect_to todos_path, notice: status_message
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :description, :priority, :due_date)
  end
end
