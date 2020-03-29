class AddSuggestedIdToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :suggested_id, :bigint
  end
end
