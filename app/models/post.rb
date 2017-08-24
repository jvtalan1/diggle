class Post < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :body, presence: true, length: { maximum: 160 }
  mount_uploader :picture, PictureUploader
  include PostsHelper

  def self.created_at
    to_pretty
  end
end
