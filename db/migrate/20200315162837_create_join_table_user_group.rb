class CreateJoinTableUserHouse < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :houses do |t|
      # t.index [:user_id, :house_id]
      # t.index [:house_id, :user_id]
      t.integer :role
    end
  end
end
