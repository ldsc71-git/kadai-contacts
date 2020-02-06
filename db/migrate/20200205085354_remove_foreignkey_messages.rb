class RemoveForeignkeyMessages < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :messages, :users
    remove_index :messages, :user_id
     remove_reference :messages, :user
  end
end
