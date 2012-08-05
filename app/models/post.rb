class Post < ActiveRecord::Base
  attr_accessible :author, :weibo_id, :content, :post_time

  belongs_to :celebrity
end
