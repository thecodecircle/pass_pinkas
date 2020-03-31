class RemovePinkasiTables < ActiveRecord::Migration[6.0]
  def change
    drop_table :regions, force: :cascade
    drop_table :families, force: :cascade
    drop_table :houses, force: :cascade
    drop_table :my_houses, force: :cascade
  end
end
