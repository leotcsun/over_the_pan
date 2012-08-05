class AddMoreColumnsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :weibo_id, :bigint
    add_column :posts, :original_pic, :string
    add_column :posts, :retweeted_id, :bigint
    add_column :posts, :retweeted_screen_name, :string
    add_column :posts, :retweeted_text, :string
    add_column :posts, :retweeted_original_pic, :string
  end
end
