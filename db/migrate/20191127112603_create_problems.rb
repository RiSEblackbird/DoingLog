class CreateProblems < ActiveRecord::Migration[6.0]
  def change
    create_table :problems do |t|
      t.string :title
      t.text :summary
      t.boolean :solved, null: false, default: false

      t.timestamps
    end
  end
end