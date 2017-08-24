class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  include PostsHelper

  def self.created_at
    to_pretty
  end
end
