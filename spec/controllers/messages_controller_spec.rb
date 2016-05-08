require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  def sign_in(user)
    visit new_user_session_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    user.confirm!
    click_button "Sign in"
  end

  let(:user1) {FactoryGirl.create(:user, username: "toncica")}
  let!(:user2) {FactoryGirl.create(:user, username: "perica")}
  before(:each) do
    visit conversations_path
    sign_in user1
  end 

  describe "creating message" do

    it "creates new message" do
      subject = "Message subject"
      body = "Message body"
      click_link "Compose Message"
      find('#recipients_select').find(:xpath, 'option[4]').select_option 
      fill_in "message_subject", with: subject
      fill_in "message_body", with: body
      click_button "Send message"
      expect(page).to have_content("Message has been sent!")

      click_link "Sent"

      expect(user1.mailbox.sentbox.first.subject).to eq(subject)

      expect(user2.mailbox.inbox.first.subject).to eq(subject)
    end


  end
end