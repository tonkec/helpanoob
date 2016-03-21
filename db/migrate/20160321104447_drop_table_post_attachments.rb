class DropTablePostAttachments < ActiveRecord::Migration
  def change
    drop_table :post_attachments do |t|
      t.integer  :post_id, null: false
      t.string   :avatar, null: false
      t.timestamps null: false
    end
  end
end
