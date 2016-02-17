class Post < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
  belongs_to :user
  belongs_to :group
  has_many :comments, dependent: :destroy

  validates :description, presence: true
  validates :group_id, presence: true
  default_scope -> { order(created_at: :desc) }
end
