class UserProfile < ApplicationRecord
  belongs_to :user
  validates :username, presence: true, uniqueness: true
  validates :user, presence: true
  mount_uploader :picture, PictureUploader
end
