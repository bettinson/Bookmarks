class Bookmark < ApplicationRecord
  belongs_to :user
  has_many :tags
  validates :description, presence: true
  validates :url, presence: true
end
