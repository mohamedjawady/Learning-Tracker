class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :update_progress]

  def index
    @articles = Article.order(:created_at)
    @articles = @articles.where('title ILIKE ?', "%#{params[:search]}%") if params[:search].present?
    @articles = @articles.where(status: params[:status]) if params[:status].present?
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: "📄 Article '#{@article.title}' was successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "✏️ Article '#{@article.title}' was successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    title = @article.title
    @article.destroy
    redirect_to articles_url, notice: "🗑️ Article '#{title}' was successfully deleted!"
  end

  def update_progress
    updated = false
    
    # Handle time spent updates
    if params[:time_spent].present?
      @article.update(time_spent: params[:time_spent])
      updated = true
    end
    
    # Handle status updates
    if params[:article] && params[:article][:status].present?
      @article.update(status: params[:article][:status])
      updated = true
    end
    
    # If this is an AJAX request, return JSON
    if request.xhr?
      render json: { success: true, progress: @article.progress_percentage }
    else
      # For regular form submissions, redirect with appropriate message
      status_message = case @article.status
      when 'completed'
        "✅ Article '#{@article.title}' marked as completed!"
      when 'in_progress'
        "▶️ Article '#{@article.title}' marked as in progress!"
      else
        "📄 Article '#{@article.title}' status updated!"
      end
      
      redirect_to @article, notice: status_message
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :author, :url, :description, :status, :estimated_read_time, :time_spent)
  end
end
