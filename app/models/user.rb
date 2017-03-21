class User < ApplicationRecord
  has_secure_password
  has_many :bookmarks
  has_many :reactions

  has_many :tags, through: :bookmarks
  validates :email, uniqueness: true
end
