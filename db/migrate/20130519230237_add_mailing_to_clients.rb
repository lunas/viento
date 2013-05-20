class AddMailingToClients < ActiveRecord::Migration
  def change
    add_column :clients, :mailing, :boolean
  end
end
