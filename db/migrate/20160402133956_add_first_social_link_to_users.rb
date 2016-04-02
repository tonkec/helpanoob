class AddFirstSocialLinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_social_link, :string
  end
end
