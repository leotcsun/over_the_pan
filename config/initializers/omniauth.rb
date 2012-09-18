Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, AppConfig['weibo_app_key'], AppConfig['weibo_app_secret']
end