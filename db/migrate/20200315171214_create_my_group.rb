class CreateMyGroup < ActiveRecord::Migration[6.0]
  def change
    create_table :my_groups do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.integer :role
    end
  end
end
