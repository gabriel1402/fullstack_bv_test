class IncrementUrlVisitsJob < ApplicationJob
  queue_as :default

  def perform(url_id)
    begin
      url = Url.find(url_id)
    rescue ActiveRecord::RecordNotFound => e 
      puts e
      return
    end
    url.update(visits: url.visits + 1)
  end
end
