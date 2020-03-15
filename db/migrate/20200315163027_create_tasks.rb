class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :score
      t.text :description
      t.integer :privacy
      t.integer :approved

      t.timestamps
    end
  end
end
