module PiecesHelper

  def piece_sortable(column, title = nil)
    direction = sort_direction_for column
    title ||= column.titleize
    css_class = (column == sort_column) ? "current_column #{direction}" : nil
    direction = (column == sort_column && direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil,
                                collection: collection_condition), {:class => css_class}
  end

  def times(number=nil)
    word = case
    when number.nil?
       "nie"
    when (1..3).member?(number)
        %w[einmal zweimal dreimal][number-1]
    when number > 3
        "#{number.to_s} mal"
    else
        "nie"
    end
  end

end
