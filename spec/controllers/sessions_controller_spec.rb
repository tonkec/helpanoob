require 'rails_helper'

describe "User Authentication" do

  subject { page }

  describe "signin page" do
    before { visit new_user_session_path }
    let(:submit) { "Log In" }

    describe "log in" do
      before { visit new_user_session_path }

      describe "with invalid information" do 
        before { click_button "Log in" }
        it { should have_selector(:link_or_button, 'Log in') }
      end

      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email",    with: user.email.upcase
          fill_in "Password", with: user.password
          click_button "Log in"
        end

        it { should have_link('Log out', href: destroy_user_session_path) }
       # it { should have_link('Profile', href: profile_path) }
        #it { should have_link('Questions', href: posts_path) }
        it { should_not have_link('Log in', href: new_user_session_path) }

      end
    end
  end
end