class AddAdminToUsers < ActiveRecord::Migration[6.1]
  def change
    #add to column users, column name, admin, of type boolean, with the default set to false for all users
    add_column :users, :admin, :boolean, default: false
  end
end
