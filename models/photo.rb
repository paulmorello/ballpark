
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

class Photo < ActiveRecord::Base
  belongs_to :sport
  belongs_to :user

  mount_uploader :image, MyUploader

  validates :title, :image, presence: true
end
