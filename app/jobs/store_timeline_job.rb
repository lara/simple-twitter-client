class StoreTimelineJob
  include SuckerPunch::Job

  def perform(client, user)
    StoreTimelineService.new(client, user).store
  end
end
