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

  def get_last_post_id
    last_post_id = self.posts.order("weibo_post_id DESC").limit(1).first
    (last_post_id) ? last_post_id.weibo_post_id : 0
  end

  def update_information(screen_name)
    response = Weibo.user_show_by_screen_name(screen_name)

    self.screen_name = response["screen_name"]
    self.domain = response["domain"]
    self.uid = response["id"]
  end

  def synchornize_post(params = {})
    params[:page] = 1
    params[:count] = 200
    up_to_date = false
    last_updated_post_id = get_last_post_id

    while !up_to_date
      response = Weibo.statuses_user_timeline(self.uid, params)
      break if response['statuses'].empty?

      response['statuses'].each do |status|
        # puts status.to_yaml

        if status['id'].to_i <= last_updated_post_id
          up_to_date = true
          puts 'all posts are synchornized'
          break
        end

        post = Post.new
        post.weibo_post_id = status['id']
        post.celebrity_id = self.id
        post.content = status['text'].gsub(/[']/, '\'\'')
        post.post_time = Time.parse(status['created_at']).to_time
        post.picture = status['original_pic'] if status['original_pic']

        if status['retweeted_status']
          retweet = status['retweeted_status']
          post.retweeted_post_id = retweet['id']
          post.retweeted_content = retweet['text']
          post.picture = retweet['oringial_pic'] if retweet['original_pic']
          if retweet['user']
            post.retweeted_screen_name = retweet['user']['screen_name']
          end
        end

        post.save
      end
      params[:page] += 1

      # puts "params[:page] #{params[:page]} #{last_update_id}"
    end
  end
end
