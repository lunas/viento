class AddSalesCountToClients < ActiveRecord::Migration
  def change
    add_column :clients, :sales_count, :integer
  end
end
