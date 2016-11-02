class MyUploader < CarrierWave::Uploader::Base
  storage :file
end



# CarrierWave.configure do |config|
#   config.fog_credentials = {
#     :provider               => 'AWS',
#     :aws_access_key_id      => 'yyy',
#     :aws_secret_access_key  => 'xxx'
#   }
#   config.fog_directory  = 'ballpark-wdi9'
# end
#
# class MyUploader < CarrierWave::Uploader::Base
#   storage :fog
# end
