class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy, :complete]
  before_action :set_course, only: [:index, :new, :create]

  def index
    @videos = @course.videos.order(:order_number)
  end

  def show
  end

  def new
    @video = @course.videos.build
  end

  def create
    @video = @course.videos.build(video_params)
    
    if @video.save
      redirect_to course_path(@course), notice: "🎬 Video '#{@video.title}' was successfully created!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @video.update(video_params)
      redirect_to course_path(@video.course), notice: "✏️ Video '#{@video.title}' was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @video.destroy
    redirect_to course_path(@video.course), notice: "🗑️ Video '#{@video.title}' was successfully deleted!"
  end

  def complete
    @video.update(
      completed: true, 
      completed_at: Time.current,
      watched_minutes: @video.duration_minutes
    )
    redirect_back(fallback_location: root_path, notice: "🎬 Video '#{@video.title}' completed! Keep up the great work!")
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id]) if params[:course_id]
  end

  def video_params
    params.require(:video).permit(:title, :description, :order_number, :duration_minutes, :watched_minutes, :completed)
  end
end
