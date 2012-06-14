Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, '686588720', '609017109a1d8311686e410aca21a268'
end