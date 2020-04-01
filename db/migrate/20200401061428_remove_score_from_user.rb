class RemoveScoreFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :score, :integer
  end
end
