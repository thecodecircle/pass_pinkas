class RemoveForeignKeyFromMyTask < ActiveRecord::Migration[6.0]
  def change
		remove_foreign_key :my_tasks, column: :house_id
  end
end
