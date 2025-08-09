class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :update_progress]

  def index
    @courses = current_user.courses.includes(:chapters, :videos, :labs).order(:created_at)
    @courses = @courses.where('title ILIKE ?', "%#{params[:search]}%") if params[:search].present?
    @courses = @courses.where(status: params[:status]) if params[:status].present?
  end

  def show
    @chapters = @course.chapters.ordered
    @videos = @course.videos.ordered
    @labs = @course.labs.ordered
    @progress_data = {
      chapters: @chapters.map { |c| { name: c.title, completed: c.completed } },
      videos: @videos.map { |v| { name: v.title, completed: v.completed, progress: v.progress_percentage } },
      labs: @labs.map { |l| { name: l.title, completed: l.completed } }
    }
  end

  def new
    @course = current_user.courses.build
  end

  def create
    @course = current_user.courses.build(course_params)

    if @course.save
      redirect_to @course, notice: "🎓 Course '#{@course.title}' was successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: "✏️ Course '#{@course.title}' was successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    title = @course.title
    @course.destroy
    redirect_to courses_url, notice: "🗑️ Course '#{title}' was successfully deleted!"
  end

  def update_progress
    if params[:progress_type] == 'overall'
      @course.update(current_progress: params[:progress])
    end
    
    render json: { success: true, progress: @course.progress_percentage }
  end

  private

  def set_course
    @course = current_user.courses.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :instructor, :platform, :url, :status, :start_date, :target_completion_date, :current_progress, :total_duration_hours, :difficulty_level)
  end
end
