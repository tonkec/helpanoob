require 'rails_helper'

RSpec.describe Notification, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  

  context ".notifications" do
	  	before do
	  	@user = FactoryGirl.build(:user)
	  	@notification = FactoryGirl.build(:notification)
	  end

	  # I want current_user to be notified of a message.


	  it "notify the recepient" do
	  	expect(@notification).to respond_to(:post)
		end

  end
end
