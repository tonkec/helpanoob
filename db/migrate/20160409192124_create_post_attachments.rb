class CreatePostAttachments < ActiveRecord::Migration
  def change
    create_table :post_attachments do |t|
      t.references :post, index: true, foreign_key: true
      t.string :title
      t.string :description
      t.text :attachemnts

      t.timestamps null: false
    end
  end
end
