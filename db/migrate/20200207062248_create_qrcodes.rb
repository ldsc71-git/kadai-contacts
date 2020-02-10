class CreateQrcodes < ActiveRecord::Migration[5.2]
  def change
    create_table :qrcodes do |t|
      t.string :qr
      t.references :user, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :qr], unique: true
    end
  end
end
