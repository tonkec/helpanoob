class AddFilesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :files, :text
  end
end
