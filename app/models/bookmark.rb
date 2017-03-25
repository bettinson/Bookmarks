class Bookmark < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :reactions
  validates :description, presence: true
  validates :url, presence: true

  def init
    self.score ||= 0
  end
end
