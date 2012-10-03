class ChangePostContentToText < ActiveRecord::Migration
  def change
    change_column :posts, :content, :text
    change_column :posts, :retweeted_content, :text
  end
end
