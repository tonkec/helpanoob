class Post < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  belongs_to :group
  has_many :comments, dependent: :destroy

  validates :description, presence: true
end
