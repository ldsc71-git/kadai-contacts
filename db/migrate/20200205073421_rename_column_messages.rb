class RenameColumnMessages < ActiveRecord::Migration[5.2]
  def change
    rename_column :messages, :read, :unread
    change_column_default :messages, :unread, true
  end
end
