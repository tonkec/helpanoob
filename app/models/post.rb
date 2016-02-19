class Post < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
  acts_as_votable
  belongs_to :user
  belongs_to :group
  has_many :comments, dependent: :destroy
  validates :description, presence: true
  validates :group_id, presence: true
  default_scope -> { order(cached_votes_up: :desc) }

  def next
    user.posts.where("id > ?", id).first
  end

  def prev
    user.posts.where("id < ?", id).last
  end
end
