class AddAgeToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :age, :integer
  end
end
