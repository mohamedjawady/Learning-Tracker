class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :update_progress, :viewer]

  def index
    @books = Book.includes(:chapters).order(:created_at)
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
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully deleted.'
  end

  def update_progress
    if params[:current_page].present?
      @book.update(current_page: params[:current_page])
    end
    
    render json: { success: true, progress: @book.progress_percentage }
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
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :description, :isbn, :status, :start_date, :target_completion_date, :current_page, :total_pages, :pdf_file)
  end
end
