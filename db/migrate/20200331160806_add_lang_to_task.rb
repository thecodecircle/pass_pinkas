class AddLangToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :lang, :string
  end
end
