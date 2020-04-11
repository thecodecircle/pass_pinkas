class AddSeenTutorialToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :seen_tutorial, :integer
  end
end
