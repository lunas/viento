class AnalysisController < ApplicationController

  def index
    @page_title = "Auswertung"
  end

  def by_size
    @page_title = "Auswertung pro Groesse"
    @table = Piece.table_by_size params[:collection]
    @analyzed_by = :size
    render :result
  end

  def by_color
    @page_title = "Auswertung pro Color"
    @table = Piece.table_by_color params[:collection]
    @analyzed_by = :color
    render :result
  end

  def by_fabric
    @page_title = "Auswertung pro Material"
    @table = Piece.table_by_fabric params[:collection]
    @analyzed_by = :fabric
    render :result
  end

  def by_collection
    @page_title = "Auswertung pro Kollektion"
    @table = Piece.table_by_collection params[:from], params[:to]
    @analyzed_by = :collection
    render :result
  end

end