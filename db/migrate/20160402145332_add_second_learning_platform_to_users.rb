class AddSecondLearningPlatformToUsers < ActiveRecord::Migration
  def change
    add_column :users, :second_learning_platform, :string
  end
end
