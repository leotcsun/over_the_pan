class SyncWorker
  include Sidekiq::Worker

  def perform(celebrity_id, full_sync)
    celebrity = Celebrity.find_by_id(celebrity_id)
    celebrity.synchornize_post(full_sync: full_sync)
  end
end