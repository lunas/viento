class SeedController < ApplicationController

  def index
    flash[:notice] = "Welcome to the Concrete Interactive Seed application."
  end
end
