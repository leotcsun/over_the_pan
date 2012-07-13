class CelebritiesController < ApplicationController

  def new
    @celebrity = Celebrity.new
  end

  def create
    Rails.logger = Logger.new(STDOUT)
    user_timeline = "https://api.t.sina.com.cn/users/show.json"

    screen_name = params[:celebrity][:screen_name]
    access_token = current_user.get_access_token
    options = { source: "686588720", access_token: access_token, screen_name: screen_name }

    response = RestClient.get(user_timeline, params: options, type: :json) do |a, b, c|
      data = JSON.parse(a.body)
      @celebrity = Celebrity.new
      @celebrity.domain = data['domain']
      @celebrity.uid = data['id'].to_i
      @celebrity.screen_name = data['screen_name']
      @celebrity.save
    end

    redirect_to root_path
  end

  def index
    @celebrities = Celebrity.all
  end

  def show
    @celebrity = Celebrity.find(params[:uid])
  end
end
