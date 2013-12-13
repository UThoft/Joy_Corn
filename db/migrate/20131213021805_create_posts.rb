class CreatePosts < ActiveRecord::Migration
  def change
    # User can have several posts.
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :password, null: false
      t.timestamps
    end

    # Post can have several comments and one User.
    create_table :posts do |t|
      t.string :type, null: false
      t.boolean :like, null: false
      t.belongs_to :user, foreign_key: "user_id"
      t.timestamps
    end
    # Maybe there should be a column, post_comment_number, which can release the
    # pressure of the database.

    create_table :tags do |t|
      t.string :name, null: false
      #t.string :classification, null: false
    end

    # There should be a join_table to store the like information.
    # One record in the join_table means the User likes the Post.
    create_join_table(:users, :posts, id: false) do |t|

    end

    # There should be a join_table to store the tag information.
    create_join_table(:posts, :tags, id: false) do |t|

    end

    # One Text/Image/Audio/Video belongs to one post.
    create_table :texts do |t|
      t.belongs_to :post, foreign_key: "post_id"
      t.string :content, limit: 250, null: false
    end

    create_table :images do |t|
      t.belongs_to :post, foreigh_key: "post_id"
      t.string :link, null: false
    end

    create_table :audios do |t|
      t.belongs_to :post, foreigh_key: "post_id"
      t.string :link, null: false
    end

    create_table :videos do |t|
      t.belongs_to :post
      t.string :link, null: false
    end
  end
end
