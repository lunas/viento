class AddSalesCountToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :sales_count, :integer
  end
end
