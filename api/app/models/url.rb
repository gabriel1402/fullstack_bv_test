class Url < ApplicationRecord
  validates :url, presence: true
  validate :validate_url

  def validate_url
    new_url = URI.parse(url) rescue errors.add(:url, "invalid URL")
    unless new_url.kind_of?(URI::HTTP) || new_url.kind_of?(URI::HTTPS)
      errors.add(:url, "invalid URL")
    end
  end
end
    