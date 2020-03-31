class RenameHouseUserTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :houses_users, :house_users
  end
end
