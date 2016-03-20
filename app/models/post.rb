# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  description             :text
#  user_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  group_id                :integer
#  title                   :string
#  image                   :string
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  comments_count          :integer          default(0)
#

class Post < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
  acts_as_votable
  belongs_to :user
  belongs_to :group
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :description, presence: true, length: {minimum: 50}
  validates :group_id, presence: true, length: {minimum: 100}
  validates :user_id, presence: true
  default_scope -> { order(cached_votes_up: :desc) }


  scope :uncommented, -> {
    where(:comments_count => 0)
  }
  def next
    user.posts.where("id > ?", id).first
  end

  def prev
    user.posts.where("id < ?", id).last
  end
end
