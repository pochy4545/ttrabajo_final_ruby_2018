class RemoveErrorFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :string, :string
  end
end
