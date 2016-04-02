class AddSecondSocialLinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :second_social_link, :string
  end
end
