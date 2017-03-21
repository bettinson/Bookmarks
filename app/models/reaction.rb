class Reaction < ApplicationRecord
  belongs_to :bookmark
  belongs_to :user
  validates :liked, presence: true
  validates :user, presence: true
  validates :bookmark, presence: true
end
