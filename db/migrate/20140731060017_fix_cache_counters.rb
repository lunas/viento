class FixCacheCounters < ActiveRecord::Migration

  # Adds :default=>0 to the sales_count columns of pieces and clients.
  # To do this, first removes the column and then adds it again with the default.

  def up
    remove_column :clients, :sales_count
    remove_column :pieces, :sales_count
    add_column :clients, :sales_count, :integer, :default => 0
    add_column :pieces, :sales_count, :integer, :default => 0

    update_cache(Client)
    update_cache(Piece)
  end

  def down
    remove_column :clients, :sales_count
    remove_column :pieces, :sales_count
    add_column :clients, :sales_count, :integer
    add_column :pieces, :sales_count, :integer

    update_cache(Client)
    update_cache(Piece)
  end

  def update_cache(model)
    model.reset_column_information
    model.all.each do |m|
      model.update m.id, sales_count: m.sales.length
    end
  end
end
