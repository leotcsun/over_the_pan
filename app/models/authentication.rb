# == Schema Information
#
# Table name: authentications
#
#  id           :integer         not null, primary key
#  user_id      :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  access_token :string(255)
#

class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :uid, :access_token
end
