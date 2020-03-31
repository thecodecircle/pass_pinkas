class RemovePinkasiColumns < ActiveRecord::Migration[6.0]
  def change
    drop_table :movements, force: :cascade
  end
end
