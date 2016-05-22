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
  acts_as_votable
  acts_as_taggable

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy  

  validates :title, presence: true, length: {minimum: 20, max: 200}, uniqueness: true

  has_many :notifications, dependent: :destroy

  validates :description, presence: true, length: {minimum: 50}
  validates :user_id, presence: true
  validates :tag_list, presence: true
  validate :tag_list_inclusion                 


  default_scope -> { order(created_at: :desc) }
  scope :uncommented, -> {
    where(:comments_count => 0)
  }


  def next
    user.posts.where("id > ?", id).first
  end

  def prev
    user.posts.where("id < ?", id).last
  end

  def tag_list_inclusion
    tag_list.each do |tag|
      errors.add(tag,"is not valid programming language") unless %w(jquery ruby rails php css html javascript sql react angular python node other).include?(tag)
    end
  end
end
