# == Schema Information
#
# Table name: celebrities
#
#  id          :integer         not null, primary key
#  uid         :integer
#  screen_name :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Celebrity < ActiveRecord::Base
  attr_accessible :uid, :screen_name

  validates :screen_name, presence: true
end
