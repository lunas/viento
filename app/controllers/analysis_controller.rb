class AnalysisController < ApplicationController

  expose(:collection){ params[:analysis][:collection].present? ? params[:analysis][:collection] : nil }
  expose(:date_from) { params[:analysis][:date_from] || Sale.minimum(:date) }
  expose(:date_to)   { params[:analysis][:date_to]   || Sale.maximum(:date) }

  def index
    @page_title = "Auswertung"
  end

  def by_size
    @page_title = "Auswertung pro Groesse"
    @page_subtitle = create_subtitle get_criteria
    @table = Piece.table_by_size collection
    @analyzed_by = :size
    render :result
  end

  def by_color
    @page_title = "Auswertung pro Color"
    @page_subtitle = create_subtitle get_criteria
    @table = Piece.table_by_color collection
    @analyzed_by = :color
    render :result
  end

  def by_fabric
    @page_title = "Auswertung pro Material"
    @page_subtitle = create_subtitle get_criteria
    @table = Piece.table_by_fabric collection
    @analyzed_by = :fabric
    render :result
  end

  def by_collection
    @page_title = "Auswertung pro Kollektion"
    @page_subtitle = create_subtitle get_criteria
    @table = Piece.table_by_collection date_from, date_to
    @analyzed_by = :collection
    render :result
  end

end