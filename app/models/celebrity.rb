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

  def synchornize_post(full_sync = false)
    weibo_params = {}
    weibo_params[:page] = 1
    weibo_params[:count] = 200
    up_to_date = false

    last_updated_post_id = (full_sync) ? 0 : get_last_post_id

    while !up_to_date
      response = Weibo.statuses_home_timeline(weibo_params)

      puts "RESPONSE@@@@@@@@@@@@@"
      puts response.inspect

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

        pic_urls = status['pic_urls'] or []
        pic_urls ||= []
        pic_urls.each do |pic_url|
          post.pictures << Picture.create(post_id: post.id, url: pic_url['thumbnail_pic'].gsub("\/thumbnail\/", "\/large\/"))
        end

        if status['retweeted_status']
          retweet = status['retweeted_status']
          post.retweeted_post_id = retweet['id']
          post.retweeted_content = retweet['text']

          retweet_pic_urls = status['retweeted_status']['pic_urls'] or []
          retweet_pic_urls ||= []
          retweet_pic_urls.each do |pic_url|
            post.pictures << Picture.create(post_id: post.id, url: pic_url['thumbnail_pic'].gsub("\/thumbnail\/", "\/large\/"))
          end

          if retweet['user']
            post.retweeted_screen_name = retweet['user']['screen_name']
          end
        end

        post.save
      end
      weibo_params[:page] += 1

      # puts "params[:page] #{params[:page]} #{last_update_id}"
    end
  end
end
