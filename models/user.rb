class User < ActiveRecord::Base
  has_secure_password

  has_many :photos
  has_many :videos
  has_many :comments
end
