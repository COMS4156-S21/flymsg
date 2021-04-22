class CreateUserKeys < ActiveRecord::Migration[6.1]
  def change
    create_table :user_keys do |t|
      t.string :user_id
      t.text :pem

      t.timestamps
    end
  end
end
