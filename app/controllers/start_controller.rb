class StartController < ApplicationController

  def index
    flash[:notice] = t :start
  end
end
