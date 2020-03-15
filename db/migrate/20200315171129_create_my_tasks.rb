class CreateMyTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :my_tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.integer :progress

      t.timestamps
    end
  end
end
