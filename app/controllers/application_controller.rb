class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def per_page
    if params[:per_page].present?
      pp = params[:per_page].to_i
      [5, 10, 15, 20, 25, 50, 100, 200, 500, 1000, 9999].include?(pp) ?
          pp : Settings.instance.per_page
    else
      Settings.instance.per_page
    end
  end

  # Returns a hash that has
  # in any case a key :name
  # maybe a key :collection
  # maybe a key :attribute which has a value of either
  #   :date, "pieces.size", "pieces.color", "pieces.fabric"
  # If there is a key "attribute", there is also a key :value
  # containing a value corresponding to the attribute;
  # if :attribute is :date, then value is a range (date_from..date_to).
  def get_criteria
    parameters = params[:analysis] ? params[:analysis] : params
    criteria = { name: parameters[:name] }
    criteria[:collection] = parameters[:collection] if parameters[:collection].present?
    if parameters[:date_from].present?
      criteria[:attribute] = :date
      criteria[:value] = date_from..date_to
      return criteria
    end
    [:size, :color, :fabric].each do |attr|
      if parameters[attr].present?
        criteria[:attribute] = "pieces.#{attr}"
        criteria[:value] = parameters[attr]
        return criteria
      end
    end
    criteria
  end

end
