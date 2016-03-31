class RemoveGroupIdFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :group_id, :integer
  end
end
