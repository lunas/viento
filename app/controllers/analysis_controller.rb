class AnalysisController < ApplicationController

  expose(:collection){ params[:analysis][:collection].present? ?
                       params[:analysis][:collection] : nil }
  expose(:date_from) { params[:analysis][:date_from].present? ?
                       params[:analysis][:date_from] : Sale.minimum(:date).to_s }
  expose(:date_to)   { params[:analysis][:date_to].present? ?
                       params[:analysis][:date_to] : Sale.maximum(:date).to_s }

  def index
    @page_title = t('analysis.index.title')
  end

  def by_size
    @page_title = t('analysis.by_size.title')
    @page_subtitle = create_subtitle get_criteria
    @table = Piece.table_by_size collection
    @analyzed_by = :size
    render :result
  end

  def by_color
    @page_title = t('analysis.by_color.title')
    @page_subtitle = create_subtitle get_criteria
    @table = Piece.table_by_color collection
    @analyzed_by = :color
    render :result
  end

  def by_fabric
    @page_title = t('analysis.by_fabric.title')
    @page_subtitle = create_subtitle get_criteria
    @table = Piece.table_by_fabric collection
    @analyzed_by = :fabric
    render :result
  end

  def by_collection
    @page_title = t('analysis.by_collection.title')
    @page_subtitle = create_subtitle get_criteria
    @table = Piece.table_by_collection date_from, date_to
    @analyzed_by = :collection
    render :result
  end

  private

  def create_subtitle(criteria)
    if criteria[:attribute] == :date
      value = criteria[:value]
      return t('analysis.sold_between', from: value.begin, to: value.end)
    end
    if criteria[:collection].present?
      return t('analysis.collection', collection: criteria[:collection])
    else
      return t('analysis.all_collections')
    end
  end


end