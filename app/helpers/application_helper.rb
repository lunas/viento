module ApplicationHelper

  def filter_menu_item(column, value)
    tmp = params.merge(status: status_condition, role: role_condition)
    link_to value, tmp.merge( "#{column}" => value)
  end

  def per_page_options
    [5,10,15,20,15,30,50,100,200,500,1000,10000]
  end

end
