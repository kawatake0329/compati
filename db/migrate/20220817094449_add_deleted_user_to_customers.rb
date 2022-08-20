class AddDeletedUserToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :deleted_user, :boolean, null: false, default: true
  end
end
