class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :update_progress, :viewer]

  def index
    @books = current_user.books.includes(:chapters).order(:created_at)
    @books = @books.where('title ILIKE ?', "%#{params[:search]}%") if params[:search].present?
    @books = @books.where(status: params[:status]) if params[:status].present?
  end

  def show
    @chapters = @book.chapters.ordered
    @progress_data = {
      chapters: @chapters.map { |c| { name: c.title, completed: c.completed } },
      pages: {
        current: @book.current_page || 0,
        total: @book.total_pages || 0
      }
    }
  end

  def new
    @book = current_user.books.build
  end

  def create
    @book = current_user.books.build(book_params)

    if @book.save
      redirect_to @book, notice: "📚 Book '#{@book.title}' was successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "✏️ Book '#{@book.title}' was successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    title = @book.title
    @book.destroy
    redirect_to books_url, notice: "🗑️ Book '#{title}' was successfully deleted!"
  end

  def update_progress
    if params[:current_page].present?
      Rails.logger.info "Updating book #{@book.id} current_page from #{@book.current_page} to #{params[:current_page]}"
      
      if @book.update(current_page: params[:current_page])
        Rails.logger.info "Successfully updated book current_page to #{@book.current_page}"
        @book.update_status_based_on_progress
        
        render json: { 
          success: true, 
          progress: @book.progress_percentage,
          current_page: @book.current_page,
          message: "📈 Progress updated to page #{@book.current_page}!"
        }
      else
        Rails.logger.error "Failed to update book: #{@book.errors.full_messages}"
        render json: { 
          success: false, 
          error: "Failed to update progress: #{@book.errors.full_messages.join(', ')}"
        }, status: :unprocessable_entity
      end
    else
      Rails.logger.error "No current_page parameter provided"
      render json: { 
        success: false, 
        error: "Current page parameter is required"
      }, status: :bad_request
    end
  end

  def viewer
    if @book.has_pdf?
      render :viewer
    else
      redirect_to @book, alert: 'No PDF file available for this book.'
    end
  end

  private

  def set_book
    @book = current_user.books.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :description, :isbn, :status, :start_date, :target_completion_date, :current_page, :total_pages, :pdf_file)
  end
end
