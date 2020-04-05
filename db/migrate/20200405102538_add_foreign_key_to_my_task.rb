class AddForeignKeyToMyTask < ActiveRecord::Migration[6.0]
  def change
			add_foreign_key :my_tasks, :houses
  end
end
