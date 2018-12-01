class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :screen_name
      t.string :string
      t.string :email

      t.timestamps
    end
  end
end
