class RenamePiecesCountToCountProduced < ActiveRecord::Migration
  def change
    rename_column :pieces, :count_produced, :count_produced
  end

end
