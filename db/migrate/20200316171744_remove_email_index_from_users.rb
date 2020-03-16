class RemoveEmailIndexFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_index "email", name: "index_users_on_email"
  end
end
