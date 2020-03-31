class CreateHouses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses do |t|
      t.string :name
      t.integer :score
      t.references :family, null: false, foreign_key: true

      t.timestamps
    end
  end
end
