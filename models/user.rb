class User < ActiveRecord::Base
  has_secure_password

  has_many :photos
  has_many :videos
  has_many :comments

  validates :email, :username, :password, presence: true
  validates :email, :username, uniqueness: true
  validates :password, length: { in: 4..20 }
end
