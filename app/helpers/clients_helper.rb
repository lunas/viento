module ClientsHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current_column #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil,
                                status: status_condition, role: role_condition), {:class => css_class}
  end

  def count_pieces_phrase(client)
    c = client.reload.sales.size
    if c == 0
      "Noch nichts gekauft."
    elsif c == 1
      "Bisher ein 1 Teil gekauft fuer #{client.sales_total}:"
    else
      "Bisher #{c} Teile gekauft fuer CHF #{client.sales_total}:"
    end
  end

end
