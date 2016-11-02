class Photo < ActiveRecord::Base
  belongs_to :sport
  belongs_to :user

  validates :title, presence: true
end
