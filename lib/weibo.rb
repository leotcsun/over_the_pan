class Weibo
  API_BASE = "https://api.weibo.com/2"

  USER_SHOW = "#{API_BASE}/users/show.json"

  STATUSES_USER_TIMELINE = "#{API_BASE}/statuses/user_timeline.json"
  STATUSES_UPDATE = "#{API_BASE}/statuses/update.json"
  STATUSES_TIMELINE_BATCH = "#{API_BASE}/statuses/timeline_batch.json"
  STATUSES_HOME_TIMELINE = "#{API_BASE}/statuses/home_timeline.json"

  class << self

    def user_show(params = {})
      params[:access_token] = Authentication.get_access_token
      JSON.parse(RestClient.get(USER_SHOW,
                                params: params))
    end

    def user_show_by_screen_name(screen_name, params = {})
      params[:screen_name] = screen_name
      user_show(params)
    end

    def user_show_by_uid(uid, params = {})
      params[:uid] = uid
      user_show(params)
    end

    def statuses_user_timeline(uid, params = {})
      params[:uid] = uid
      params[:access_token] = Authentication.get_access_token
      JSON.parse(RestClient.get(STATUSES_USER_TIMELINE,
                                params: params))
    end

    def statuses_update(uid, params = {})
      user_id = User.find_by_uid(uid)
      params[:access_token] = Authentication.find_by_user_id(user_id)
                                            .access_token
      JSON.parse(RestClient.post(STATUSES_UPDATE,
                                 params: params))
    end

    def statuses_timeline_batch(uids, params = {})
      params[:uids] = uids
      params[:access_token] = Authentication.get_access_token
      JSON.parse(RestClient.get(STATUSES_TIMELINE_BATCH,
                                params: params))
    end

    def statuses_home_timeline(params = {})
      params[:access_token] = Authentication.get_access_token
      JSON.parse(RestClient.get(STATUSES_HOME_TIMELINE,
                                params: params))
  end
end

