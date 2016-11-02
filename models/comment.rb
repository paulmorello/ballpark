class Comment < ActiveRecord::Base
  belongs_to :videos
  belongs_to :photos
  belongs_to :user

  validates :body, presence: true
end
