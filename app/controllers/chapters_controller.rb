class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show, :edit, :update, :destroy, :complete]
  before_action :set_course, only: [:index, :new, :create]

  def index
    @chapters = @course.chapters.order(:order_number)
  end

  def show
  end

  def new
    @chapter = @course.chapters.build
  end

  def create
    @chapter = @course.chapters.build(chapter_params)
    
    if @chapter.save
      redirect_to course_path(@course), notice: "📖 Chapter '#{@chapter.title}' was successfully created!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @chapter.update(chapter_params)
      redirect_to course_path(@chapter.course || @chapter.book), notice: "✏️ Chapter '#{@chapter.title}' was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @chapter.destroy
    redirect_to course_path(@chapter.course || @chapter.book), notice: "🗑️ Chapter '#{@chapter.title}' was successfully deleted!"
  end

  def complete
    @chapter.update(completed: true, completed_at: Time.current)
    redirect_back(fallback_location: root_path, notice: "🎉 Chapter '#{@chapter.title}' marked as complete! Great progress!")
  end

  private

  def set_chapter
    @chapter = Chapter.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id]) if params[:course_id]
  end

  def chapter_params
    params.require(:chapter).permit(:title, :description, :order_number, :page_start, :page_end, :completed)
  end
end
