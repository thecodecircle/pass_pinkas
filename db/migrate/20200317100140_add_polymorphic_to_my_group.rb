class AddPolymorphicToMyGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :my_groups, :my_groupable_id, :bigint
    add_column :my_groups, :my_groupable_type, :string
    remove_column :my_groups, :group_id, :bigint
    # remove_index "group_id", name: "index_my_groups_on_group_id"
  end
end
