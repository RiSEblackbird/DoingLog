# frozen_string_literal: true

class CreateDoingLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :doing_logs do |t|
      t.string :title, null: false
      t.text :summary

      t.timestamps
    end
  end
end
