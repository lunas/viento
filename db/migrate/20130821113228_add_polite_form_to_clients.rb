class AddPoliteFormToClients < ActiveRecord::Migration
  def change
    add_column :clients, :polite_form, :boolean, default: true
  end
end
