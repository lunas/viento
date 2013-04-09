class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def per_page
    pp = params[:per_page].to_i
    [5, 10, 15, 20, 25, 50, 100, 200, 500, 1000, 9999].include?(pp) ? pp : 15
  end

  def get_criteria
    parameters = params[:analysis] ? params[:analysis] : params
    criteria = { name: parameters[:name] }
    criteria[:collection] = parameters[:collection] if parameters[:collection]
    if parameters[:date_from].present?
      criteria[:attribute] = :date
      criteria[:value] = parameters[:date_from]..parameters[:date_to]
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

  def create_subtitle(criteria)
    if criteria.has_key? :attribute
      if criteria[:attribute] == :date
        attribute = "verkauft zwischen "
        value = criteria[:value]
        value = "#{value.begin} und #{value.end}"
      else
        attribute = criteria[:attribute].gsub("pieces.", "").capitalize
        if criteria.has_key? :value
          value = criteria[:value] == 'total Anzahl' ? 'alle' : criteria[:value]
        end
      end
    end

    name = criteria[:name] == 'total Anzahl' ? 'alle' : criteria[:name]
    subtitle = "#{name}, #{attribute} #{value}".strip
    subtitle += ", Kollektion #{criteria[:collection]}" if criteria.has_key?(:collection) && criteria[:collection] != 'total Anzahl'
    subtitle
  end

end
