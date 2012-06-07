# == Schema Information
#
# Table name: celebrities
#
#  id         :integer         not null, primary key
#  uid        :integer
#  domain     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Celebrity < ActiveRecord::Base
  attr_accessible :uid, :domain

  validates :domain, presence: true, uniqueness: { case_sensitive: false }
end
