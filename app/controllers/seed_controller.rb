class SeedController < ApplicationController

  def index
    flash[:notice] = "Welcome to Viento"
  end
end
