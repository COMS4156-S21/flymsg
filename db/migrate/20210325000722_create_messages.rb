class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :img_id
      t.string :source_user_id
      t.string :target_user_id

      t.timestamps
    end
  end
end
