class Reaction < ApplicationRecord
  belongs_to :bookmark
  belongs_to :user
  validates :user, presence: true
  validates :bookmark, presence: true
end
