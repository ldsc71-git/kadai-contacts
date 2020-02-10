class RemoveForeignkeyQrcodes < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :qrcodes, :users
    remove_index :qrcodes, :user_id
    remove_reference :qrcodes, :user
  end
end
