class Post < ActiveRecord::Base

  attr_accessible :author, :weibo_id, :content, :post_time
  belongs_to :celebrity

  def self.synchornize(celebrity_id, uid, params = {})
    params[:page] = 1
    params[:count] = 200
    up_to_date = false

    while !up_to_date
      response = Weibo.statuses_user_timeline(uid, params)
      break unless response['statuses']

      response['statuses'].each do |status|
        # puts s.to_yaml

        if status['id'].to_i <= last_updated_post_id
          up_to_date = true
          break
        end

        post = Post.new
        post.id = status['id']
        post.celebrity_id = celebrity_id
        post.content = status['text'].gsub(/[']/, '\'\'')
        post.post_time = Time.parse(s['created_at']).to_time

        if status['retweeted_status']
          retweet = statuses['retweeted_status']
          post.retweet_post_id = retweet['id']
          post.retweet_screen_name = retweet['user']['screen_name']
          post.content = retweet['text']
          post.picture = status['original_pic'] or retweet['original_pic']
        end

        post.save
        params[:page] += 1
      end
    end
  end
end
