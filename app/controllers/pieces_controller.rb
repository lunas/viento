class PiecesController < ApplicationController

  before_filter :authenticate_user!

  helper_method :sort_column, :sort_direction, :collection_condition, :per_page

  expose(:available){ params[:available].present? ? params[:available] : false}

  # GET /pieces
  # GET /pieces.json
  def index
    second_order = sort_column == 'name' ? 'collection desc' : 'name'
    @pieces = Piece.filter(params[:search], collection_condition)
                   .order("#{sort_column} #{sort_direction}, #{second_order}" )
                   .paginate(:per_page => per_page, :page => params[:page])
    @page_title = t('pieces.index.pieces')

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @pieces }
    end
  end

  # GET /pieces/find?term=abc
  def find
    term = "%#{params[:term]}%"
    @pieces = Piece.where("name like ?", term)
                   .order("collection DESC, name, fabric, size, color")
                   .limit(100)
    respond_to do |format|
      format.html
      format.js
      format.json {render json: @pieces.map(&:id_with_info_and_price)}
    end
  end

  def collection

  end

  # GET /pieces/1
  # GET /pieces/1.json
  def show
    @piece = Piece.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @piece }
    end
  end

  # GET /pieces/new
  # GET /pieces/new.json
  def new
    @piece = Piece.new
    @page_title = t('pieces.new.piece')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @piece }
    end
  end

  def copy
    @piece = Piece.find(params[:id]).dup # create a new copy
    #@piece.id = nil
    @page_title = t('pieces.copy.piece')
    render action: "new"
  end

  # GET /pieces/1/edit
  def edit
    @piece = Piece.find(params[:id])
    @page_title = t('pieces.edit.piece')
  end

  # POST /pieces
  # POST /pieces.json
  def create
    @piece = Piece.new(params[:piece])

    respond_to do |format|
      if @piece.save
        format.html do
          if params[:copy_new]
            redirect_to copy_piece_path(@piece.id), notice: t('pieces.create.created', info: @piece.info)
          else
            redirect_to pieces_path, notice: t('pieces.create.created', info: @piece.info)
          end
        end
        format.json { render json: @piece, status: :created, location: @piece }
      else
        @page_title = t('pieces.new.piece')
        format.html { render action: "new" }
        format.json { render json: @piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pieces/1
  # PUT /pieces/1.json
  def update
    @piece = Piece.find(params[:id])

    respond_to do |format|
      if @piece.update_attributes(params[:piece])
        format.html do
          if params[:copy_new]
            redirect_to copy_piece_path(@piece.id), notice: t('pieces.update.updated', info: @piece.info)
          else
            redirect_to pieces_path, notice: t('pieces.update.updated', info: @piece.info)
          end
        end
        format.json { head :no_content }
      else
        @page_title = t('pieces.edit.piece')
        format.html { render action: "edit" }
        format.json { render json: @piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pieces/1
  # DELETE /pieces/1.json
  def destroy
    @piece = Piece.find(params[:id])
    @piece.destroy

    respond_to do |format|
      format.html do
        flash[:success] = t('pieces.destroy.destroyed', info: @piece.info)
        redirect_to pieces_url
      end
      format.json { head :no_content }
    end
  end


  private

  def sort_column
    (Piece.column_names + ['stock', 'sold']).include?(params[:sort]) ? params[:sort] : "name"
  end

  def collection_condition(collection = params[:collection_filter])
    collection ||= Piece.latest_collection
    (Piece.collections << 'alle').include?(collection) ? collection: nil
  end


end
