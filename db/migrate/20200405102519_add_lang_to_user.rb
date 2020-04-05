class AddLangToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :lang, :string
  end
end
