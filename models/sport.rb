class Sport < ActiveRecord::Base
  has_many :videos
  has_many :photos
end
