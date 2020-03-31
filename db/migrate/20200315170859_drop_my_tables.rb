class DropMyTables < ActiveRecord::Migration[6.0]
  def change
      drop_table :my_tasks
      drop_table :my_houses
  end
end
