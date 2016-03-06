require 'rails_helper'
require 'spec_helper'
require 'byebug'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit sign_up_path }
    let(:submit) { "Sign up" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end #it
    end #invalid info

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Nickname", with: user.nickname
        fill_in "Email",        with: user.email
        fill_in "Password",     with: user.password
        fill_in "Repeat Password", with: user.password_confirmation
        
        #find('#user_avatar', visible: false).set user.avatar
        attach_file('user_avatar', user.avatar)
        #fill_in "user_avatar", with: user.avatar
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
        expect { response.should redirect_to(posts_path) }
      end
    end #valid info

  end #signup pages


end #User Paged
