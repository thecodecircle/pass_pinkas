class EditUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :admin, :boolean
    add_column :users, :role, :integer
    add_column :users, :score, :integer
  end
end
