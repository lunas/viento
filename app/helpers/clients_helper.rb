module ClientsHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current_column #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil,
                                status: status_condition, role: role_condition), {:class => css_class}
  end

  def count_pieces_phrase(count, total)
    if count == 0
      "Noch nichts gekauft."
    elsif count == 1
      "Bisher ein 1 Teil gekauft fuer #{total}:"
    else
      "Bisher #{count} Teile gekauft fuer #{total}:"
    end
  end

end
