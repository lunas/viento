class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :client_id
      t.integer :piece_id
      t.date :date
      t.decimal :actual_price

      t.timestamps
    end
  end
end
