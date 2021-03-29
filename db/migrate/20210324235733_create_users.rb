class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.binary :hashed_pwd
      t.binary :salt

      t.timestamps
    end
  end
end
