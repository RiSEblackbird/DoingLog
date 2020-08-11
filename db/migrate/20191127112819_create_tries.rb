# frozen_string_literal: true

class CreateTries < ActiveRecord::Migration[6.0]
  def change
    create_table :tries do |t|
      t.string :title, null: false
      t.text :body
      t.boolean :effective, null: false, default: false

      t.timestamps
    end
  end
end
