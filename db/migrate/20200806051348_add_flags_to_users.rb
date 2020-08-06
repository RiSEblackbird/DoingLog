class AddFlagsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin_flg, :boolean, default: false
    add_column :users, :guest_flg, :boolean, default: false
  end
end
