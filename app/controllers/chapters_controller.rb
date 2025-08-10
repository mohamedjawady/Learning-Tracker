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
    if @chapter.completed?
      @chapter.mark_incomplete!
      message = "📖 Chapter '#{@chapter.title}' marked as incomplete."
    else
      @chapter.mark_completed!
      message = "🎉 Chapter '#{@chapter.title}' marked as complete! Great progress!"
    end
    
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, notice: message) }
      format.json { render json: { success: true, message: message, completed: @chapter.completed } }
    end
  end

  private

  def set_chapter
    # Find chapters that belong to either courses or books owned by current user
    @chapter = Chapter.joins('LEFT JOIN courses ON chapters.course_id = courses.id')
                     .joins('LEFT JOIN books ON chapters.book_id = books.id')
                     .where('courses.user_id = ? OR books.user_id = ?', current_user.id, current_user.id)
                     .find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Chapter not found or you do not have permission to access it.'
  end

  def set_course
    @course = current_user.courses.find(params[:course_id]) if params[:course_id]
  end

  def chapter_params
    params.require(:chapter).permit(:title, :description, :order_number, :page_start, :page_end, :completed)
  end
end
