class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def per_page
    pp = params[:per_page].to_i
    [5, 10, 15, 20, 25, 50, 100, 1000].include?(pp) ? pp : 15
  end

end
