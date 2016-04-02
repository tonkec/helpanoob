class AddFirstLearningPlatformToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_learning_platform, :string
  end
end
