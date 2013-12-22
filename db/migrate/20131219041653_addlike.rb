class Addlike < ActiveRecord::Migration
  def change
    create_table :like do |t|
      t.belongs_to :user
      t.belongs_to :posts
      t.timestamps
    end
  end
end
