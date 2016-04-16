# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  description             :text
#  user_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
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

  serialize :images, Array
  mount_uploaders :images, AvatarUploader
  acts_as_votable
  acts_as_taggable

  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: {minimum: 20, max: 200}
  validates :description, presence: true, length: {minimum: 100}
  validates :user_id, presence: true
  default_scope -> { order(cached_votes_up: :desc) }

  scope :uncommented, -> {
    where(:comments_count => 0)
  }

  validate :tag_list_inclusion                 

  def next
    user.posts.where("id > ?", id).first
  end

  def prev
    user.posts.where("id < ?", id).last
  end

  def tag_list_inclusion
    tag_list.each do |tag|
      errors.add(tag,"is not valid programming language") unless %w(jquery ruby rails php css html javascript sql react angular).include?(tag)
    end
  end
end
