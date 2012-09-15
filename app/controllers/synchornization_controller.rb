class SynchornizationController < ApplicationController

  def synchornize

  end


  # def update_post(uid)
  #   page = 1
  #   inserts = []
  #   last_existing_post_id = get_last_post_id
  #   up_to_date = false

  #   while !up_to_date
  #     response = Weibo.statuses_user_timeline(uid, page)
  #     break unless response['statuses']

  #     response['statuses'].each do |s|
  #       # puts s.to_yaml

  #       # stop if this post is already saved
  #       if s['id'].to_i <= last_existing_post_id
  #         up_to_date = true
  #         break
  #       end

  #       # post values
  #       id = s['id']
  #       text = s['text'].gsub(/[']/, '\'\'')
  #       post_time = Time.parse(s['created_at']).to_time
  #       pic = s['original_pic']

  #       # retweeted values
  #       if s['retweeted_status']
  #         r = s['retweeted_status']
  #         retweeted_id = r['id']
  #         retweeted_text = r['text']
  #         retweeted_screen_name = r['user']['screen_name'] if r['user']
  #         retweeted_pic = r['orignal_pic']
  #       else
  #         retweeted_id = 0
  #         retweeted_text, retweeted_screen_name, retweeted_pic = nil
  #       end

  #       values = <<-VALUES
  #         ('#{self.id}', '#{id}', '#{text}',
  #          '#{Time.new}', '#{Time.new}', '#{post_time}',
  #          '#{retweeted_id}', '#{retweeted_screen_name}', '#{retweeted_text}',
  #          '#{pic}', '#{retweeted_pic}')
  #       VALUES

  #       inserts.push values
  #     end
  #     page += 1
  #   end

  #   if inserts.length > 0
  #     Celebrity.connection.execute <<-SQL
  #       INSERT INTO posts
  #       (celebrity_id, weibo_id, content,
  #        created_at, updated_at, post_time,
  #        retweeted_id, retweeted_screen_name, retweeted_text,
  #        original_pic, retweeted_original_pic)
  #       VALUES #{inserts.join(", ")}
  #     SQL
  #   end
  # end
end
