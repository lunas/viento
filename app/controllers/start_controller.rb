class StartController < ApplicationController

  before_filter :authenticate_user!

  def index
    #@page_title = t('start.index.title')
    @collections = Piece.revenue_by_collection
  end
end
