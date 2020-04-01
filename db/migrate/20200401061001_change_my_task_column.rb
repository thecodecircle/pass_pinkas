class ChangeMyTaskColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :my_tasks, :user_id, :house_id
  end
end
