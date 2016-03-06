require 'rails_helper'
require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit sign_up_path }
    it { should have_selector('a',    text: 'Sign In') }
    let(:submit) { "Sign In" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_link submit }.not_to change(User, :count)
      end #it
    end #invalid info

    describe "with valid information" do
      before do
        fill_in "Nickname", with: "Jura"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Repeat Password", with: "foobar"
        attach_file('user_avatar', "#{Rails.root}/spec/acceptance/test_uploads/sweal.jpg", visible: false)
      end

      it "should create a user" do
        expect { click_link submit }.to change(User, :count).by(1)
      end
    end #valid info

  end #signup pages


end #User Paged
