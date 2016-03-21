class DropTableGroups < ActiveRecord::Migration
  def change
    drop_table :groups do |t|
      t.string :title, null: false
      t.timestamps null: false
    end
  end
end
