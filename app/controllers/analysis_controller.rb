class AnalysisController < ApplicationController

  def index
    @page_title = "Auswertung"
  end

  def by_size
    @page_title = "Auswertung pro Groesse"
    @table = Piece.table_by_size params[:collection]
    render :result
  end

  def by_color
    @page_title = "Auswertung pro Color"
    @table = Piece.table_by_color params[:collection]
    render :result
  end

  def by_fabric
    @page_title = "Auswertung pro Material"
    @table = Piece.table_by_fabric params[:collection]
    render :result
  end

  def by_collection
    @page_title = "Auswertung pro Kollektion"
    @table = Piece.table_by_collection params[:from], params[:to]
    render :result
  end

end