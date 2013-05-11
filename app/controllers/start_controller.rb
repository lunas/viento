class StartController < ApplicationController

  before_filter :authenticate_user!
  before_filter(only: :index) { @page_caching = true }

  caches_page :index

  def index
    #@page_title = t('start.index.title')
    @collections = Piece.revenue_by_collection
  end
end
