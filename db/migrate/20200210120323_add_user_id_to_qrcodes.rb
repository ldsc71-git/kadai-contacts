class AddUserIdToQrcodes < ActiveRecord::Migration[5.2]
  def change
    add_column :qrcodes, :user_id, :bigint
  end
end
