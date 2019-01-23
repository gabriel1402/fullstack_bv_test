class StoreUrlTitleJob < ApplicationJob
  queue_as :default

  def perform(url_id)
    begin
      url = Url.find(url_id)
    rescue ActiveRecord::RecordNotFound => e 
      puts e
      return
    end
    response = HTTParty.get(url.url)
    html = Nokogiri::HTML.parse(response.body)
    url.update(title: html.title)
  end
end
