class StartController < ApplicationController

  def index
    flash[:notice] = "start"
  end
end
