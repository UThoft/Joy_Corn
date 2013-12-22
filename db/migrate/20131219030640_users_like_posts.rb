class UsersLikePosts < ActiveRecord::Migration
  def change

    create_join_table :users, :posts do |t|
      t.index :user_id
      t.index :post_id
      t.timestamps

    end
  end
end
