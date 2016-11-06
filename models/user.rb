
CarrierWave.configure do |config|
  config.fog_credentials = {

    :provider              => 'AWS',
    :aws_access_key_id     => ENV['S3_KEY'],
    :aws_secret_access_key => ENV['S3_SECRET'],
    :region                => 'ap-southeast-2', # sydney
    :host   => 's3-ap-southeast-2.amazonaws.com'
  }

  config.storage = :fog
  config.fog_directory = ENV['S3_BUCKET']

end

class MyUploader < CarrierWave::Uploader::Base
  storage :fog
end

class User < ActiveRecord::Base
  has_secure_password

  has_many :photos
  has_many :videos
  has_many :comments

  mount_uploader :avatar, MyUploader

  # validates :email, :username, :password, presence: true
  # validates :email, :username, uniqueness: true
  # validates :password, length: { in: 4..20 }
end
