class AddThirdSocialLinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :third_social_link, :string
  end
end
