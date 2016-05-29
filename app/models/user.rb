# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar                 :string
#  introduction           :text
#  first_name             :string
#  last_name              :string
#  username               :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  acts_as_voter
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :skills, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :username, presence: true, uniqueness: true
  validates :avatar, file_size: { less_than_or_equal_to: 2.megabytes }
  mount_uploader :avatar, AvatarUploader

  def social_link(link)

    unless link.blank?
      if link.match("codepen")
        "<a href='#{link}' target='_blank'><i class='fa fa-codepen user-link'></i></a>".html_safe 
      elsif link.match("github")
        "<a href='#{link}' target='_blank'><i class='fa fa-github user-link'></i></a>".html_safe
      elsif link.match("twitter")
        "<a href='#{link}' target='_blank'><i class='fa fa-twitter user-link'></i></a>".html_safe
      elsif link.match("stackoverflow")
        "<a href='#{link}' target='_blank'><i class='fa fa-stack-overflow user-link'></i></a>".html_safe        
      elsif link.match("linkedin")
        "<a href='#{link}' target='_blank'><i class='fa fa-linkedin user-link'></i></a>".html_safe 
      elsif link.match("codecademy")
        "<a href='#{link}' target='_blank'><i class='user-link'>Codecademy</i></a>".html_safe 
      elsif link.match("codeschool")
        "<a href='#{link}' target='_blank'><i class='user-link'>Codeschool</i></a>".html_safe 
      elsif link.match("freecodecamp")
        "<a href='#{link}' target='_blank'><i class='user-link'>Freecodecamp</i></a>".html_safe 
      else
        "<a href='#{link}' target='_blank'><i class='fa fa-link user-link'></i></a>".html_safe 
      end
    end

  end

  def website_link(link)
    unless link.blank?
       "<a href='#{link}' target='_blank' class='user-link'>website</a>".html_safe 
    end
  end

end