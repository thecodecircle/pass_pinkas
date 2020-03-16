class ChangeTasksColumnNames < ActiveRecord::Migration[6.0]
  def change
    rename_column :tasks, :privacy, :publicity
    rename_column :tasks, :approved, :status
  end
end
