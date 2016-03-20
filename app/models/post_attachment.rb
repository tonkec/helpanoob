# == Schema Information
#
# Table name: post_attachments
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  avatar     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostAttachment < ActiveRecord::Base
   mount_uploader :avatar, AvatarUploader
   belongs_to :post
end
