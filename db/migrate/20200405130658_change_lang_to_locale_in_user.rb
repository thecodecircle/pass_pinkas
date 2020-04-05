class ChangeLangToLocaleInUser < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :lang, :locale
  end
end
