class AddReferenceMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :user_id
    add_reference :messages, :user, foreign_key: true
  end
end
