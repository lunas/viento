module SalesHelper

  def back_path(parent)
    if parent.is_a? Client
      edit_client_path(parent)
    elsif parent.is_a? Piece
      edit_piece_path(parent)
    else
      clients_path
    end
  end

  def sale_sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current_column #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

end
