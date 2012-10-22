class SalesController < ApplicationController

  before_filter :authenticate_user!

  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sales }
    end
  end

  # GET /sales/new
  # GET /clients/1/sales/new
  # GET /pieces/1/sales/new
  # GET /sales/new.json
  def new
    @sale = Sale.new
    prepare_new_sale
    @page_title = 'Neuer Verkauf'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sale }
    end
  end

  # GET /sales/1/edit
  # GET /clients/1/sales/2/edit
  # GET /pieces/1/sales/2/edit
  def edit
    @sale = Sale.find(params[:id])
    @parent = find_current_parent
    @page_title = 'Verkauf bearbeiten'
  end

  # POST /sales
  # POST /pieces/1/sales
  def create
    @sale = Sale.new(params[:sale])

    respond_to do |format|
      if @sale.save
        format.html { redirect_to back_url, notice: "Verkauf gespeichert: #{@sale.info}" }
        format.json { render json: @sale, status: :created, location: @sale }
      else
        format.html do
          @page_title = 'Neuer Verkauf'
          render action: "new"
        end
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sales/1
  # PUT /clients/1/sales/2
  # PUT /pieces/1/sales/2
  def update
    @sale = Sale.find(params[:id])

    respond_to do |format|
      if @sale.update_attributes(params[:sale])
        format.html { redirect_to back_url, notice: "Verkauf gespeichert: #{@sale.info}" }
        format.json { head :no_content }
      else
        format.html do
          render action: "edit"
          @page_title = 'Verkauf bearbeiten'
        end
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /clients/1/sales/2
  # DELETE /pieces/1/sales/2
  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy

    respond_to do |format|
      format.html { redirect_to back_url, notice: "Verkauf geloescht: #{@sale.info}" }
      format.json { head :no_content }
    end
  end

  private

  def prepare_new_sale
    @sale.client_id = params[:client_id] || nil
    @sale.piece_id, @sale.date =  params[:piece_id] || nil
    @sale.date = Date.today
    @parent = @sale.client || @sale.piece
  end

  def find_current_parent
    case
    when params[:client_id]
      @sale.client
    when params[:piece_id]
      @sale.piece
    else
      nil
    end
  end

  def back_url
    client_id = params[:client_id]
    if client_id
      edit_client_path(client_id)
    else
      piece_id = params[:piece_id]
      if piece_id
        edit_piece_path(piece_id)
      else
        clients_path
      end
    end
  end

  end
