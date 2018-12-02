class RemoveTokenFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :token
    remove_column :users, :token, :string
  end
end
