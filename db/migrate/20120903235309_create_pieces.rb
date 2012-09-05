class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :name
      t.string :collection
      t.string :color
      t.string :fabric
      t.integer :size
      t.integer :count
      t.decimal :price
      t.decimal :costs

      t.timestamps
    end
  end
end
