class AddConnectIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :connect_uid, :string
  end
end
