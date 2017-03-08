class User < ApplicationRecord
  has_secure_password
  has_many :bookmarks
  validates :email, uniqueness: true
end
