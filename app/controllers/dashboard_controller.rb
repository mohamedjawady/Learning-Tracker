class DashboardController < ApplicationController
  before_action :set_current_date

  def index
    @courses = Course.includes(:chapters, :videos, :labs).limit(6)
    @books = Book.includes(:chapters).limit(6)
    @articles = Article.limit(6)
    @recent_activity = recent_learning_activity
    @today_events = CalendarEvent.today.includes(:eventable)
    @pending_todos = Todo.pending.limit(5)
    @weekly_progress = calculate_weekly_progress
  end

  def progress
    @courses_progress = Course.all.map do |course|
      {
        name: course.title,
        progress: course.progress_percentage,
        status: course.status
      }
    end

    @books_progress = Book.all.map do |book|
      {
        name: book.title,
        progress: book.progress_percentage,
        status: book.status
      }
    end

    @articles_progress = Article.all.map do |article|
      {
        name: article.title,
        progress: article.progress_percentage,
        status: article.status
      }
    end
  end

  private

  def recent_learning_activity
    activities = []
    
    # Recent completed chapters
    activities += Chapter.where('completed_at > ?', 7.days.ago)
                        .includes(:course, :book)
                        .order(completed_at: :desc)
                        .limit(5)
                        .map { |c| { type: 'chapter', item: c, time: c.completed_at } }

    # Recent completed videos
    activities += Video.where('completed_at > ?', 7.days.ago)
                      .includes(:course)
                      .order(completed_at: :desc)
                      .limit(5)
                      .map { |v| { type: 'video', item: v, time: v.completed_at } }

    # Recent completed labs
    activities += Lab.where('completed_at > ?', 7.days.ago)
                    .includes(:course)
                    .order(completed_at: :desc)
                    .limit(5)
                    .map { |l| { type: 'lab', item: l, time: l.completed_at } }

    activities.sort_by { |a| a[:time] }.reverse.first(10)
  end

  def calculate_weekly_progress
    start_of_week = Date.current.beginning_of_week
    end_of_week = Date.current.end_of_week

    {
      chapters_completed: Chapter.where(completed_at: start_of_week..end_of_week).count,
      videos_completed: Video.where(completed_at: start_of_week..end_of_week).count,
      labs_completed: Lab.where(completed_at: start_of_week..end_of_week).count,
      todos_completed: Todo.where(completed_at: start_of_week..end_of_week).count
    }
  end
end
