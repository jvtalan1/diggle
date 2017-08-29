class UserProfile < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  belongs_to :user
  mount_uploader :picture, PictureUploader
end
