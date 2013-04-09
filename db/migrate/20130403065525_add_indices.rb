class AddIndices < ActiveRecord::Migration
  def up
    add_index :sales, :client_id, :name => 'client_id_ix'
    add_index :sales, :piece_id,  :name => 'piece_id_ix'
    add_index :sales, :actual_price, :name => 'actual_price_ix'
    add_index :sales, :date, :name => 'date_ix'

    add_index :clients, :last_name, name: 'last_name_ix'
    add_index :clients, :first_name, name: 'first_name_ix'
    add_index :clients, :city, name: 'city_ix'
    add_index :clients, :street, name: 'street_ix'
    add_index :clients, :status, name: 'status_ix'
    add_index :clients, :roles_mask, name: 'roles_mask_ix'

    add_index :pieces,  :name, name: 'name_ix'
    add_index :pieces,  :collection, name: 'collection_ix'
    add_index :pieces,  :color, name: 'color_ix'
    add_index :pieces,  :fabric, name: 'fabric_ix'
    add_index :pieces,  :size, name: 'size_ix'
    add_index :pieces,  :price, name: 'price_ix'
    add_index :pieces,  :count_produced, name: 'count_produced_ix'
  end

  def down
    remove_index :sales, name: :client_id_ix
    remove_index :sales, name: :piece_id_ix
    remove_index :sales, name: :actual_price_ix
    remove_index :sales, name: :date_ix

    remove_index :clients, name: :last_name_ix
    remove_index :clients, name: :first_name_ix
    remove_index :clients, name: :city_ix
    remove_index :clients, name: :street_ix
    remove_index :clients, name: :statux_ix
    remove_index :clients, name: :roles_mask_ix

    remove_index :pieces, name: :name_ix
    remove_index :pieces, name: :collection_ix
    remove_index :pieces, name: :color_ix
    remove_index :pieces, name: :fabric_ix
    remove_index :pieces, name: :size_ix
    remove_index :pieces, name: :prize_ix
    remove_index :pieces, name: :count_produced_ix
  end
end
