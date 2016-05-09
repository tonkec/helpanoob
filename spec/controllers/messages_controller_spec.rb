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
 

  describe "creating message" do
  
    it "creates new message and shows notification" do
      visit conversations_path
      sign_in user1
      subject = "Message subject"
      body = "Message body"
      click_link "Compose Message"
      find('#recipients_select').find(:xpath, 'option[4]').select_option 
      fill_in "message_subject", with: subject
      fill_in "message_body", with: body
      click_button "Send message"
      expect(page).to have_content("Message has been sent!")
      expect(user1.mailbox.sentbox.first.subject).to eq(subject)
      expect(user2.mailbox.inbox.first.subject).to eq(subject)
      expect(user2.mailbox.inbox).not_to be_empty

      find(:xpath, "//a[@href='/users/sign_out']").click
      
      sign_in user2
      expect(page).to have_content("#{user1.username} sent you a message!")
      expect(page).to have_content(user1.username)

    end
  end


end