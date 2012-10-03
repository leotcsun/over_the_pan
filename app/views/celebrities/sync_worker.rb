class SyncWorker
  include Sidekiq::Worker

  def perform(celebrity, params = {})
    celebrity.synchornize_post
  end
end