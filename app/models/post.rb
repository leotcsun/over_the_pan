class Post < ActiveRecord::Base

  attr_accessible :author, :weibo_post_id, :content, :post_time
  belongs_to :celebrity

  validates :weibo_post_id, uniqueness: true
end
