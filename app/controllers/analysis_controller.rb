class AnalysisController < ApplicationController

  def index
    @page_title = "Auswertung"
  end

  def by_size
    @page_title = "Auswertung pro Groesse"
    @table = Piece.table_by_size params[:collection]
  end
end