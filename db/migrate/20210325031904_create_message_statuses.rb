class CreateMessageStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :message_statuses do |t|
      t.string :img_id
      t.string :unread
      t.string :deleted
      t.timestamp :created_on
      t.int :ttl

      t.timestamps
    end
  end
end
