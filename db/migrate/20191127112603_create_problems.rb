# frozen_string_literal: true

class CreateProblems < ActiveRecord::Migration[6.0]
  def change
    create_table :problems do |t|
      t.string :title, null: false
      t.text :summary
      t.boolean :solved, null: false, default: false

      t.timestamps
    end
  end
end
