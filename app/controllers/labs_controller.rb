class LabsController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update, :destroy, :complete]
  before_action :set_course, only: [:index, :new, :create]

  def index
    @labs = @course.labs.order(:order_number)
  end

  def show
  end

  def new
    @lab = @course.labs.build
  end

  def create
    @lab = @course.labs.build(lab_params)
    
    if @lab.save
      redirect_to course_path(@course), notice: "🧪 Lab '#{@lab.title}' was successfully created!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @lab.update(lab_params)
      redirect_to course_path(@lab.course), notice: "✏️ Lab '#{@lab.title}' was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @lab.destroy
    redirect_to course_path(@lab.course), notice: "🗑️ Lab '#{@lab.title}' was successfully deleted!"
  end

  def complete
    @lab.update(completed: true, completed_at: Time.current)
    redirect_back(fallback_location: root_path, notice: "🧪 Lab '#{@lab.title}' completed! Excellent hands-on work!")
  end

  private

  def set_lab
    @lab = Lab.joins(:course).where(courses: { user: current_user }).find(params[:id])
  end

  def set_course
    @course = current_user.courses.find(params[:course_id]) if params[:course_id]
  end

  def lab_params
    params.require(:lab).permit(:title, :description, :order_number, :notes, :completed)
  end
end
