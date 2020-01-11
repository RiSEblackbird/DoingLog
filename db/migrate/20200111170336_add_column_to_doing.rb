class AddColumnToDoing < ActiveRecord::Migration[6.0]
  def change
    add_column :doings, :user_id, :integer
  end
end
