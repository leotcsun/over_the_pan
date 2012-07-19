# == Schema Information
#
# Table name: celebrities
#
#  id          :integer         not null, primary key
#  uid         :integer
#  domain      :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  screen_name :string(255)
#

class Celebrity < ActiveRecord::Base
  attr_accessible :uid, :domain, :screen_name

  has_many :posts

  validates :uid, presence: true, uniqueness: { case_sensitive: false }
end
