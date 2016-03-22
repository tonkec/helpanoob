class ChangeNicknameColumnInUsersTable < ActiveRecord::Migration
  def change
    rename_column :users, :nickname, :username
  end
end
