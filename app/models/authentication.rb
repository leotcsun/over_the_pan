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

  class << self

    attr_accessor :usable_access_token, :token_expire_time

    def get_access_token
      @@token_expire_time ||= Time.new.to_time.to_i

      if @@token_expire_time <= Time.new.to_time.to_i
        auth = Authentication.order("updated_at DESC").limit(1).first
        if auth.nil?
          puts "cannot find an token"
          return
        end
        @@token_expire_time = auth.updated_at.to_time.to_i + (24 * 60 * 60 * 1000)
        @@usable_access_token = auth.access_token
      else
        @@usable_access_token
      end
    end

  end
end
