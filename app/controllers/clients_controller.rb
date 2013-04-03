class ClientsController < ApplicationController

  before_filter :authenticate_user!

  helper_method :sort_column, :sort_direction, :status_condition, :role_condition

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.with_sales_data
                     .filter(params[:search], status_condition, role_condition)
                     .order(sort_column + ' ' + sort_direction)
                     .paginate(:per_page => per_page, :page => params[:page])
    @page_title = 'Kundinnen'

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @clients }
    end
  end

  # GET /clients/find?term=abc
  def find
    term = "%#{params[:term]}%"
    @clients = Client.with_role('Kundinnen')
                     .with_status('aktiv')
                     .where("first_name like ? or last_name like ?", term, term)
                     .order("last_name, first_name, city")
                     .limit(20)
    respond_to do |format|
      format.html
      format.js
      format.json {render json: @clients.map(&:id_with_name_and_city)}
    end
  end

  def export
    @clients = Client.for_export
    respond_to do |format|
      format.csv { send_data @clients.to_csv }
      format.xls
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.include(sales: piece).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @page_title = 'Neue Kundin'

    @client = Client.new
    @client.role = "Kundinnen"
    @client.status = "aktiv"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @page_title = 'Kundin bearbeiten'
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create
    respond_to do |format|
      if @client.save
        format.html { redirect_to clients_path, notice: 'Kundin erstellt.' }
        format.json { render json: @client, status: :created, location: @client }
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to clients_path, notice: 'Kundin gespeichert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Kundin geloescht.' }
      format.json { head :no_content }
    end
  end

  private

  def sort_column
    (Client.column_names + %w[sales_total sales_count latest_sale_date])
          .include?(params[:sort]) ? params[:sort] : "last_name"
  end

  def status_condition(status = params[:status])
    status ||= "aktiv"
    %w[aktiv passiv alle].include?(status) ? status : nil
  end

  def role_condition(role = params[:role])
    role ||= "Kundinnen"
    (Client::ROLES + ['alle']).include?(role) ? role : nil
  end

end
