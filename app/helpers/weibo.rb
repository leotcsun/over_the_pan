class Weibo
  # require File.expand_path('../../models/authentication.rb', __FILE__)
  API_BASE = "https://api.weibo.com/2/"

  USER_SHOW = "#{API_BASE}users/show.json"
  STATUSES_USER_TIMELINE = "#{API_BASE}statuses/user_timeline.json"

  class << self
    def user_show(screen_name)
      access_token = Authentication.get_access_token
      params = { access_token: access_token, screen_name: screen_name }

      JSON.parse(RestClient.
        get(USER_SHOW, params: params, type: :json))
    end

    def statuses_user_timeline(uid, page)
      access_token = Authentication.get_access_token
      params = { access_token: access_token,
                 uid: uid,
                 page: page,
                 count: 200 }

      JSON.parse(RestClient.
        get(STATUSES_USER_TIMELINE, params: params))
    end
  end
end