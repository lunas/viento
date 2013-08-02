class RenamePiecesCountToCountProduced < ActiveRecord::Migration
  def change
    rename_column :pieces, :count, :count_produced
  end

end
