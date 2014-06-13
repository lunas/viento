class AddNotesToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :notes, :text
  end
end
