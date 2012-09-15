class ModificationsForPost < ActiveRecord::Migration
  def change
    rename_column :posts, :weibo_id, :weibo_post_id
    change_column :posts, :weibo_post_id, :bigint
    rename_column :posts, :original_pic, :picture
    rename_column :posts, :retweeted_text, :retweeted_content
    rename_column :posts, :retweeted_id, :retweeted_post_id
    change_column :posts, :retweeted_post_id, :bigint
    remove_column :posts, :retweeted_original_pic
  end
end
