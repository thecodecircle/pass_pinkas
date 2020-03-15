class CreateBranches < ActiveRecord::Migration[6.0]
  def change
    create_table :branches do |t|
      t.string :name
      t.integer :score
      t.references :region, null: false, foreign_key: true

      t.timestamps
    end
  end
end
