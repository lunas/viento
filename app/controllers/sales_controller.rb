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

  # GET /sales/1
  # GET /sales/1.json
  def show
    @sale = Sale.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sale }
    end
  end

  # GET /sales/new
  # GET /sales/new.json
  def new
    @sale = Sale.new
    @sale.client_id = params[:client_id] if params[:client_id]
    @sale.piece_id = params[:piece_id] if params[:piece_id]
    @sale.date = Date.today
    @page_title = 'Neuer Verkauf'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sale }
    end
  end

  # GET /sales/1/edit
  def edit
    @sale = Sale.find(params[:id])
  end

  # POST /sales
  # POST /sales.json
  def create
    cleanup_param

    # TODO make sure
    # client_name_and_city matches with client.id.name_and_city
    # at least one client with matching sale_client_name_and_city exists!
    # > in sale.save possible

    @sale = Sale.new(params[:sale])

    respond_to do |format|
      if @sale.save
        format.html { redirect_to clients_path, notice: 'Verkauf gespeichert.' }
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
  # PUT /sales/1.json
  def update
    cleanup_param
    @sale = Sale.find(params[:id])

    respond_to do |format|
      if @sale.update_attributes(params[:sale])
        format.html { redirect_to clients_path, notice: 'Verkauf gespeichert.' }
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
  # DELETE /sales/1.json
  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy

    respond_to do |format|
      format.html { redirect_to sales_url }
      format.json { head :no_content }
    end
  end

  private

  def cleanup_param
    #params[:sale].delete(:client_name_and_city)
    params[:sale].delete(:piece_info)
  end


  end
