class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :id
      t.string :email
      t.string :hashed_pwd

      t.timestamps
    end
  end
end
