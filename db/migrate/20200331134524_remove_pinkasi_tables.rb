class RemovePinkasiTables < ActiveRecord::Migration[6.0]
  def change
    drop_table :regions, force: :cascade
    drop_table :branches, force: :cascade
    drop_table :groups, force: :cascade
    drop_table :my_groups, force: :cascade
  end
end
