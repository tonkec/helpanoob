class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :description, presence: true
  default_scope -> { order(created_at: :desc) }
end
