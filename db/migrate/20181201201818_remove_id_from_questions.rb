class RemoveIdFromQuestions < ActiveRecord::Migration[5.2]
  def change
    remove_column :questions, :user_id, :integer
  end
end
