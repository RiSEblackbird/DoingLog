class ChangeDoingLogToDoing < ActiveRecord::Migration[6.0]
  def change
    rename_table :doing_logs, :doings
  end
end
