class AddThirdLearningPlatformToUsers < ActiveRecord::Migration
  def change
    add_column :users, :third_learning_platform, :string
  end
end
