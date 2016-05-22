# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  content    :text
#  user_id    :integer
#

class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  belongs_to :user
  acts_as_votable
  
  validates :content, presence: true, uniqueness: true
  default_scope -> { order(created_at: :desc) }

end
