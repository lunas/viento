module ApplicationHelper

  def filter_menu_item(column, value)
    tmp = params.merge(status: status_condition, role: role_condition, per_page: per_page)
    link_to value, tmp.merge( "#{column}" => value)
  end

  def per_page_options
    [5, 10, 15, 20, 25, 50, 100, 200, 500, 1000, 9999]
  end

  def nav_class_for(menu_item)
    return controller_name.to_sym == menu_item ? 'active' : ''
  end

  def understate(amount)
    if amount > Settings.instance.understate_threshold
      "<span class=\"understate\">#{amount / Settings.instance.understate_factor}</span>".html_safe
    else
      amount
    end
  end

  def flash_class(message)
    case message
      when :notice then "alert alert-info fadeout"
      when :no_fade then "alert alert-info"
      when :success then "alert alert-success fadeout"
      when :error then "alert alert-error"
      when :alert then "alert alert-error"
    end
  end

  def collection_filter(selected = Piece.latest_collection)
    selected = 'alle' if selected == ''
    collections = (Piece.collections << 'alle').map{|c| [c, c]}
    select_tag 'collection_filter',
               options_for_select(collections, selected),
               class: 'span2'
  end

  def can_see_revenue
    threshold = Settings.instance.show_revenue
    threshold = threshold.to_s
    return true if threshold == 'worker'
    if threshold == 'boss'
      return !(%w[boss admin] & current_user.roles).empty?
    end
    if threshold == 'admin'
      return current_user.roles.include? 'admin'
    end
  end

end
