class CelebritiesController < ApplicationController
  Rails.logger = Logger.new(STDOUT)

  def new
    @celebrity = Celebrity.new
  end

  def create
    user_show = "https://api.t.sina.com.cn/users/show.json"

    screen_name = params[:celebrity][:screen_name]
    access_token = current_user.get_access_token
    options = { access_token: access_token, screen_name: screen_name }

    response = RestClient.get(user_show, params: options, type: :json) do |a, b, c|
      data = JSON.parse(a.body)
      logger.info { data }
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
    @celebrity = Celebrity.find(params[:id])
    @posts = @celebrity.posts.order("weibo_post_id DESC")
  end

  def sync
    @celebrity = Celebrity.find(params[:id])
    if @celebrity
      @celebrity.synchornize_post
    end

    redirect_to @celebrity, flash[:notice] => 'Synchornization Complete'
  end


end
