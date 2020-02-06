class SetDefaultMessages < ActiveRecord::Migration[5.2]
  def change
    change_column_default :messages, :read, false
  end
end
