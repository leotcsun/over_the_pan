class AddPostTimeToPost < ActiveRecord::Migration
  def change
    add_column :posts, :post_time, :timestamp
  end
end
