# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  uid                    :integer
#

class User < ActiveRecord::Base
  has_one :authentication
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :uid
  # attr_accessible :title, :body

  validates_uniqueness_of :uid

  def save_auth(auth)
    build_authentication(access_token: auth['credentials']['token'])
  end

  def update_access_token(auth)
    authentication.access_token = auth['credentials']['token']
    Rails.logger.info { "TOKEN: #{authentication.access_token}" }
    authentication.save!
  end

  def get_access_token
    authentication.access_token
  end

  def password_required?
    false
  end

  def email_required?
    false
  end
end
