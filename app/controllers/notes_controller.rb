class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy, :move]
  before_action :set_notable, only: [:index, :new, :create]

  def index
    @notes = if @notable
               @notable.notes.root_notes.ordered.includes(:children)
             else
               Note.root_notes.ordered.includes(:children)
             end
    @new_note = Note.new
    @new_folder = Note.new(is_folder: true)
  end

  def show
    @children = @note.children.ordered
  end

  def new
    @note = Note.new
    @note.notable = @notable if @notable
    @note.parent_id = params[:parent_id] if params[:parent_id]
    @parents = Note.folders.where.not(id: @note.id)
  end

  def create
    @note = Note.new(note_params)
    @note.notable = @notable if @notable

    if @note.save
      redirect_to notes_path(notable_params), notice: "📝 Note '#{@note.title}' created successfully!"
    else
      @parents = Note.folders.where.not(id: @note.id)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @parents = Note.folders.where.not(id: @note.id)
  end

  def update
    if @note.update(note_params)
      redirect_to @note, notice: "📝 Note '#{@note.title}' updated successfully!"
    else
      @parents = Note.folders.where.not(id: @note.id)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    title = @note.title
    @note.destroy
    redirect_to notes_path, notice: "🗑️ Note '#{title}' deleted successfully!"
  end

  def move
    if params[:parent_id].present?
      new_parent = Note.find(params[:parent_id])
      @note.move_to_parent(new_parent)
    elsif params[:position].present?
      @note.move_to_position(params[:position].to_i)
    end

    render json: { success: true }
  rescue => e
    render json: { success: false, error: e.message }
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def set_notable
    if params[:notable_type] && params[:notable_id]
      @notable = params[:notable_type].constantize.find(params[:notable_id])
    end
  end

  def note_params
    params.require(:note).permit(:title, :content, :parent_id, :tags, :is_folder, :color, :position)
  end

  def notable_params
    if @notable
      { notable_type: @notable.class.name, notable_id: @notable.id }
    else
      {}
    end
  end
end
