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

require 'spec_helper'

describe Authentication do
  # pending "add some examples to (or delete) #{__FILE__}"
end
