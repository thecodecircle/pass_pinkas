class DropJoinTables < ActiveRecord::Migration[6.0]
  def change
    drop_table :tasks_users
    drop_table :houses_users
  end
end
