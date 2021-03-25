class CreateImgStorages < ActiveRecord::Migration[6.1]
  def change
    create_table :img_storages do |t|
      t.string :img_id
      t.string :img_src

      t.timestamps
    end
  end
end
