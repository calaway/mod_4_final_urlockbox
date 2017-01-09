class Link < ApplicationRecord
  validates :url, :url => true
  belongs_to :user
end
