class Comment < ActiveRecord::Base
  belongs_to :videos
  belongs_to :photos
end
