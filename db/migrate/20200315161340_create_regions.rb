class CreateRegions < ActiveRecord::Migration[6.0]
  def change
    create_table :regions do |t|
      t.string :name
      t.integer :score
      t.references :movement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
