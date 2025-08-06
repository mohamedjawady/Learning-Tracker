class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:new, :create]
  before_action :require_same_user, only: [:show, :edit, :update, :destroy]

  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      log_in(@user)
      redirect_to root_path, notice: "🎉 Welcome to Learning Tracker, #{@user.name}! Your account has been created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @courses = @user.courses.limit(5)
    @books = @user.books.limit(5)
    @todos = @user.todos.pending.limit(5)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "✅ Your profile has been updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: "🗑️ Your account has been deleted."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def require_same_user
    unless current_user == @user
      redirect_to root_path, alert: "🚫 You can only access your own profile."
    end
  end
end
