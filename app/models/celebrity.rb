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

  def synchornize_post(params = {})
    params[:page] = 1
    params[:count] = 200
    up_to_date = false
    last_updated_post_id = get_last_post_id

    while !up_to_date
      response = Weibo.statuses_user_timeline(self.uid, params)
      # puts response.to_yaml
      break unless response['statuses']

      response['statuses'].each do |status|
        # puts status.to_yaml

        if status['id'].to_i <= last_updated_post_id
          up_to_date = true
          puts 'up to date'
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
          post.retweeted_screen_name = retweet['user']['screen_name'] if retweet['user']
          post.retweeted_content = retweet['text']
          post.picture = retweet['oringial_pic'] if retweet['original_pic']
        end

        post.save
      end
      params[:page] = params[:page] + 1

      puts "params[:page] #{params[:page]} #{last_update_id}"
    end
  end


  def sync_posts
    page = 1
    inserts = []
    last_existing_post_id = get_last_post_id
    up_to_date = false

    while !up_to_date
      response = Weibo.statuses_user_timeline(self.uid, page)
      break unless response['statuses']

      response['statuses'].each do |s|
        # puts s.to_yaml

        # stop if this post is already saved
        if s['id'].to_i <= last_existing_post_id
          up_to_date = true
          break
        end

        # post values
        id = s['id']
        text = s['text'].gsub(/[']/, '\'\'')
        post_time = Time.parse(s['created_at']).to_time
        pic = s['original_pic']

        # retweeted values
        if s['retweeted_status']
          r = s['retweeted_status']
          retweeted_id = r['id']
          retweeted_text = r['text']
          retweeted_screen_name = r['user']['screen_name'] if r['user']
          retweeted_pic = r['orignal_pic']
        else
          retweeted_id = 0
          retweeted_text, retweeted_screen_name, retweeted_pic = nil
        end

        values = <<-VALUES
          ('#{self.id}', '#{id}', '#{text}',
           '#{Time.new}', '#{Time.new}', '#{post_time}',
           '#{retweeted_id}', '#{retweeted_screen_name}', '#{retweeted_text}',
           '#{pic}', '#{retweeted_pic}')
        VALUES

        inserts.push values
      end
      page += 1
    end

    if inserts.length > 0
      Celebrity.connection.execute <<-SQL
        INSERT INTO posts
        (celebrity_id, weibo_id, content,
         created_at, updated_at, post_time,
         retweeted_id, retweeted_screen_name, retweeted_text,
         original_pic, retweeted_original_pic)
        VALUES #{inserts.join(", ")}
      SQL
    end
  end
end
