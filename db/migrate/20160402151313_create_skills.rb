class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.integer :strength
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
