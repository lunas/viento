class AddMailingToClients < ActiveRecord::Migration
  def change
    add_column :clients, :mailing, :string
  end
end
