module ClientsHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current_column #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(sort: column, direction: direction, page: nil,
                                status: status_condition, role: role_condition), {class: css_class}
  end

  def count_pieces_phrase(client)
    c = client.reload.sales.size
    if c == 0
      t('clients.bought_nothing')
    elsif c == 1
      t('clients.bought_1_html', amount: understate(client.sales_total) )
    else
      t('clients.bought_more_html', num: c, amount: understate(client.sales_total) )
    end
  end

  def phone_list(client)
    phones = client.phones
    return '' if phones.empty?
    return phones.first[1] if phones.size==1
    html = '<div class="btn-group"><a href="#" class="btn dropdown-toggle btn-mini" data-toggle="dropdown">' + phones.keys.first.to_s + ': ' + phones.values.first + '<span class="caret"></span></a><ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">'
    phones.each do |key, phone|
      html += "<li><span class=\"key\">#{t('clients.phones.' + key.to_s)}: </span><span class=\"phone\">#{phone}</span></li>"
    end
    html += '</ul></div>'
    html.html_safe
  end

end
