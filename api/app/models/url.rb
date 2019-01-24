class Url < ApplicationRecord
  include Base62_Helper

  validates :url, presence: true
  validate :validate_url

  def validate_url
    new_url = URI.parse(url) rescue errors.add(:url, "invalid URL")
    unless new_url.kind_of?(URI::HTTP) || new_url.kind_of?(URI::HTTPS)
      errors.add(:url, "invalid URL")
    end
  end
  
  def self.top_100
    order(visits: :desc).all.as_json(methods: :short_url)
  end

  def self.decode_short_url(short_url)
    id = Base62_Helper.decode(short_url)
    find(id) rescue false
  end

  def short_url
    ENV['APP_URL'] + encode(id)
  end
  
end
    