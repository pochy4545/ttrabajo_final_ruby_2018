class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :description
      t.boolean :status
      t.integer :user_id
      t.integer :answer_id

      t.timestamps
    end
  end
end
