class SyncWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(celebrity_id, full_sync)
    full_sync ||= false
    celebrity = Celebrity.find_by_id(celebrity_id)
    celebrity.synchornize_post(full_sync: full_sync)
  end
end