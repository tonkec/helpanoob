class Skill < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :strength, presence: true 
end
