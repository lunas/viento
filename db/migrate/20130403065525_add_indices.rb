class AddIndices < ActiveRecord::Migration
  def up
    add_index :sales, :client_id, :name => 'client_id_ix'
    add_index :sales, :piece_id,  :name => 'piece_id_ix'

    add_index :clients, :last_name, name: 'last_name_ix'
    add_index :pieces,  :name, name: 'name_ix'
  end

  def down
    remove_index :sales, :client_id
    remove_index :sales, :piece_id

    remove_index :clients, :last_name
    remove_index :pieces,  :name
  end
end
