class CalendarEventsController < ApplicationController
  before_action :set_calendar_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = CalendarEvent.includes(:eventable).order(:start_date)
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
    @calendar_event = CalendarEvent.new
    @courses = Course.all
    @books = Book.all
    @articles = Article.all
  end

  def create
    @calendar_event = CalendarEvent.new(calendar_event_params)

    if @calendar_event.save
      redirect_to calendar_events_path, notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @courses = Course.all
    @books = Book.all
    @articles = Article.all
  end

  def update
    if @calendar_event.update(calendar_event_params)
      redirect_to calendar_events_path, notice: 'Event was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @calendar_event.destroy
    redirect_to calendar_events_path, notice: 'Event was successfully deleted.'
  end

  private

  def set_calendar_event
    @calendar_event = CalendarEvent.find(params[:id])
  end

  def calendar_event_params
    params.require(:calendar_event).permit(:title, :description, :start_date, :end_date, :event_type, :eventable_type, :eventable_id, :all_day)
  end
end
