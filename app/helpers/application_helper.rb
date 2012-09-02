module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current_column #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil,
                                status: status_condition, role: role_condition), {:class => css_class}
  end

  def filter_menu_item(column, value)
    tmp = params.merge(status: status_condition, role: role_condition)
    link_to value, tmp.merge( "#{column}" => value)
  end

end
