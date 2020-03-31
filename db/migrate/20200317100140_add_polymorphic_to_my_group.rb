class AddPolymorphicToMyHouse < ActiveRecord::Migration[6.0]
  def change
    add_column :my_houses, :my_houseable_id, :bigint
    add_column :my_houses, :my_houseable_type, :string
    remove_column :my_houses, :house_id, :bigint
    # remove_index "house_id", name: "index_my_houses_on_house_id"
  end
end
