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
end
