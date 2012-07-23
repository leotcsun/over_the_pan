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

require 'date'

class Celebrity < ActiveRecord::Base
  attr_accessible :uid, :domain, :screen_name

  has_many :posts

  validates :uid, presence: true, uniqueness: { case_sensitive: false }

  def sync_posts
    page = 1
    inserts = []

    while true
      response = Weibo.statuses_user_timeline(self.uid, page)
      break unless response['statuses']

      response['statuses'].each do |s|
        text = s['text'].gsub(/[']/, '\'\'')

        values = <<-VALUE
          ('#{self.uid}', '#{text}', '#{Time.new}', '#{Time.new}',
          '#{Time.parse(s['created_at']).to_time}')
        VALUE

        inserts.push values
      end
      page += 1
    end

    Celebrity.connection.execute <<-SQL
      INSERT INTO posts (author, content, created_at, updated_at, post_time)
      VALUES #{inserts.join(", ")}
    SQL

  end
end
