class AddJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :posts, id: true do |t|
      t.belongs_to :user
      t.belongs_to :post
      t.timestamps
    end
  end
end
