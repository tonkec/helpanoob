class Skill < ActiveRecord::Base
  belongs_to :user
  
  before_save { |skill| skill.name = skill.name.downcase }

  validates :name, presence: {message: "Skill can't be blank"}, uniqueness: {message: "You already have that skill!"}
  validates :strength, presence: true, 
            :numericality => { :greater_than_or_equal_to => 0,
                               :less_than_or_equal_to => 100,
                               only_float: true } 
end
