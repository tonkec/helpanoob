class Skill < ActiveRecord::Base
  belongs_to :user
  
  before_save { |skill| skill.name = skill.name.downcase }

  validates :name, inclusion: { in: %w(ruby php css html javascript sql react.js angular.js),
                   message: "Pick a real skill" },

                  presence: {message: "Skill can't be blank"},
                  uniqueness: {message: "You already have that skill!"}

  validates :strength, presence: {message: "Strength can't be blank!"},
            :numericality => { :greater_than_or_equal_to => 0,
                               :less_than_or_equal_to => 100,
                               only_float: {message: "Pick a number!"} } 
  default_scope -> { order(created_at: :desc) }
end
