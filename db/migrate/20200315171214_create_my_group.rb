class CreateMyHouse < ActiveRecord::Migration[6.0]
  def change
    create_table :my_houses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :house, null: false, foreign_key: true
      t.integer :role
    end
  end
end
