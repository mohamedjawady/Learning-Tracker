class CalendarEventsController < ApplicationController
  before_action :set_calendar_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = current_user.calendar_events.includes(:eventable).order(:start_date)
    @events = @events.where('start_date >= ?', params[:start_date]) if params[:start_date].present?
    @events = @events.where('start_date <= ?', params[:end_date]) if params[:end_date].present?
    
    respond_to do |format|
      format.html
      format.json { render json: @events.map(&:to_calendar_json) }
    end
  end

  def show
  end

  def new
    @calendar_event = current_user.calendar_events.build
    load_resources
  end

  def create
    @calendar_event = current_user.calendar_events.build(calendar_event_params)

    if @calendar_event.save
      redirect_to calendar_events_path, notice: 'Event was successfully created.'
    else
      load_resources
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    load_resources
  end

  def update
    if @calendar_event.update(calendar_event_params)
      redirect_to calendar_events_path, notice: 'Event was successfully updated.'
    else
      load_resources
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @calendar_event.destroy
    redirect_to calendar_events_path, notice: 'Event was successfully deleted.'
  end

  private

  def set_calendar_event
    @calendar_event = current_user.calendar_events.find(params[:id])
  end

  def load_resources
    @courses = current_user.courses.order(:title)
    @books = current_user.books.order(:title)
    @articles = current_user.articles.order(:title)
  end

  def calendar_event_params
    params.require(:calendar_event).permit(:title, :description, :start_date, :end_date, :event_type, :eventable_type, :eventable_id, :all_day)
  end
end
