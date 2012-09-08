module ApplicationHelper

  def filter_menu_item(column, value)
    tmp = params.merge(status: status_condition, role: role_condition)
    link_to value, tmp.merge( "#{column}" => value)
  end

  def per_page_options
    [5, 10, 15, 20, 25, 50, 100, 200, 500, 1000, 9999]
  end

  def nav_class_for(menu_item)
    return controller_name.to_sym == menu_item ? 'active' : ''
  end

end
