class Post < ActiveRecord::Base
  attr_accessible :author, :content, :post_time

  belongs_to :celebrity
end
