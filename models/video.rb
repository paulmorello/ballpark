class Video < ActiveRecord::Base
  belongs_to :sport
  belongs_to :user
end
