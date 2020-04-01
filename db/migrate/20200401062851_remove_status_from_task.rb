class RemoveStatusFromTask < ActiveRecord::Migration[6.0]
  def change

    remove_column :tasks, :status, :integer
  end
end
