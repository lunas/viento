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
    html  = '<a href="#" class="first"><span class="key">' + t("clients.phones.#{phones.keys.first.to_s}") + ':</span>' + phones.values.first + '</a>'
    html += '<ul class="others">'
    phones.keys[1..-1].each do |key|
      html += "<li><span class=\"key\">#{t('clients.phones.' + key.to_s)}: </span><span class=\"phone\">#{phones[key]}</span></li>"
    end
    html += '</ul>'
    html.html_safe
  end

  def notify_by(client)
    case client.mailing
      when 'home', 'work', 'mobile'
        client.send( "phone_#{client.mailing}".to_sym)
      when 'email'
        client.email
      else
        ''
    end
  end

  def status_filter
    tag('span', class: "filter_wrapper") +
        label_tag('status_filter', t('status')) +
        select_tag('status_filter', options_for_select(Client::STATES + ['alle'], status_condition), class: 'span1 filter')
  end

  def role_filter
    tag('span', class: "filter_wrapper") +
        label_tag('role_filter', t('role')) +
        select_tag('role_filter', options_for_select(Client::ROLES + ['alle'], role_condition), class: 'span2 filter')
  end

end
