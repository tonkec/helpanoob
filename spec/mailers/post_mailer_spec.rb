require "rails_helper"

RSpec.describe PostMailer, type: :mailer do

  def sign_in(user)
    visit new_user_session_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    user.confirm!
    click_button "Sign in"
  end #def

  
  let(:user) {FactoryGirl.create(:user)}

  before (:each) do
    sign_in user
  end #before
 
  describe "user should receive email when post is created" do
    before {visit new_post_path}

    it "creates as many emails as there are users" do
      description = "a" * 50
      title = "b" * 30

      fill_in "Title", with: title
      fill_in "Ask a question", with: description
      fill_in "Tags separated by commas", with: "Ruby"

      number_of_users = User.all.size
      
      expect{click_button "Ask"}.to change { ActionMailer::Base.deliveries.count }.by(number_of_users)
    end #it

  end #describe

end #RSPEC
