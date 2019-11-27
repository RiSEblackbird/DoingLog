class AddColumnToTags < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :summary, :text
  end
end
