class DashboardController < ApplicationController
  before_action :set_current_date

  def index
    # Additional safety check - this shouldn't be needed with proper authentication
    unless current_user
      redirect_to auth_path, alert: "Please log in to access your dashboard."
      return
    end
    
    @courses = current_user.courses.includes(:chapters, :videos, :labs).limit(6)
    @books = current_user.books.includes(:chapters).limit(6)
    @articles = current_user.articles.limit(6)
    @recent_activity = recent_learning_activity
    @today_events = current_user.calendar_events.today.includes(:eventable)
    @pending_todos = current_user.todos.pending.limit(5)
    @weekly_progress = calculate_weekly_progress
  end

  def progress
    @courses_progress = current_user.courses.map do |course|
      {
        name: course.title,
        progress: course.progress_percentage,
        status: course.status
      }
    end

    @books_progress = current_user.books.map do |book|
      {
        name: book.title,
        progress: book.progress_percentage,
        status: book.status
      }
    end

    @articles_progress = current_user.articles.map do |article|
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
    
    # Recent completed chapters (from user's courses and books)
    user_course_ids = current_user.courses.pluck(:id)
    user_book_ids = current_user.books.pluck(:id)
    
    activities += Chapter.where('completed_at > ? AND (course_id IN (?) OR book_id IN (?))', 
                               7.days.ago, user_course_ids, user_book_ids)
                        .includes(:course, :book)
                        .order(completed_at: :desc)
                        .limit(5)
                        .map { |c| { type: 'chapter', item: c, time: c.completed_at } }

    # Recent completed videos (from user's courses)
    activities += Video.where('completed_at > ? AND course_id IN (?)', 
                             7.days.ago, user_course_ids)
                      .includes(:course)
                      .order(completed_at: :desc)
                      .limit(5)
                      .map { |v| { type: 'video', item: v, time: v.completed_at } }

    # Recent completed labs (from user's courses)
    activities += Lab.where('completed_at > ? AND course_id IN (?)', 
                           7.days.ago, user_course_ids)
                    .includes(:course)
                    .order(completed_at: :desc)
                    .limit(5)
                    .map { |l| { type: 'lab', item: l, time: l.completed_at } }

    activities.sort_by { |a| a[:time] }.reverse.first(10)
  end

  def calculate_weekly_progress
    start_of_week = Date.current.beginning_of_week
    end_of_week = Date.current.end_of_week
    
    user_course_ids = current_user.courses.pluck(:id)
    user_book_ids = current_user.books.pluck(:id)

    {
      chapters_completed: Chapter.where(completed_at: start_of_week..end_of_week)
                                .where('course_id IN (?) OR book_id IN (?)', user_course_ids, user_book_ids)
                                .count,
      videos_completed: Video.where(completed_at: start_of_week..end_of_week)
                            .where(course_id: user_course_ids)
                            .count,
      labs_completed: Lab.where(completed_at: start_of_week..end_of_week)
                        .where(course_id: user_course_ids)
                        .count,
      todos_completed: current_user.todos.where(completed_at: start_of_week..end_of_week).count
    }
  end
end
