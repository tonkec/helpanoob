require 'rails_helper'
require 'spec_helper'

describe "User Registration" do

  subject { page }

  describe "signup page" do
    before { visit new_user_registration_path }
    let(:submit) { "Sign up" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end #it
    end #invalid info

    describe "with valid information" do
      let(:user) { FactoryGirl.build(:user) }
      before do
        fill_in "Nickname", with: user.nickname
        fill_in "Email",        with: user.email
        fill_in "Password",     with: user.password
        fill_in "Password confirmation", with: user.password_confirmation
        
       # find('#user_avatar', visible: false).set user.avatar
        attach_file('user_avatar', File.join(Rails.root, '/spec/fixtures/files/sweal.jpg'))
      #  fill_in "user_avatar", with: user.avatar

        click_button "Sign up"
      end

      it "shows message about confirmation email" do
        expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please open the link to activate your account.")
      end
      
    end #valid info

  end #signup pages


end #User Paged
