class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :company
      t.string :street_number
      t.string :zip
      t.string :country
      t.string :email
      t.string :phone_work
      t.string :phone_home
      t.string :phone_mobile
      t.text :notes
      t.integer :roles_mask
      t.string :profession
      t.string :first_name2
      t.string :last_name2
      t.string :street2
      t.string :status

      t.timestamps
    end
  end
end
