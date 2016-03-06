require 'rails_helper'
require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit sign_in_path }
    let(:submit) { "Log In" }

    describe "log in" do
      before { visit sign_in_path }

      describe "with invalid information" do 
          # link to sign up on login page proves that we are still on the same page
        it { should have_selector('a', text: 'Sign Up') }
      end

      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email",    with: user.email.upcase
          fill_in "Password", with: user.password
          click_button "Log In"
        end

        it { should have_link('Log out', href: sign_out_path) }
        it { should have_link('Profile', href: profile_path) }
        it { should have_link('Questions', href: posts_path) }
        it { should_not have_link('Sign in', href: sign_in_path) }

      end
    end
  end
end