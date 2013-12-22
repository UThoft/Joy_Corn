class UsersPosts < ActiveRecord::Migration
  def change

    create_table "posts_users", id: true, force: true do |t|
      t.integer  "user_id",    null: false
      t.integer  "post_id",    null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end


  end
end
