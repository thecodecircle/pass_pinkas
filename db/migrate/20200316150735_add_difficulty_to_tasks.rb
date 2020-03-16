class AddDifficultyToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :difficulty, :integer
  end
end
