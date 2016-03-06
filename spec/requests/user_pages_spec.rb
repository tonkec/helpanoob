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
        fill_in "Password",     with: "password"
        fill_in "Repeat Password", with: "password"
        @file = fixture_file_upload('spec/fixtures/files/sweal.jpg', 'jpg')
      end

      it "should create a user" do
        expect { click_link submit }.to change(User, :count).by(1)
        expect { response.should redirect_to(posts_path) }
      end
    end #valid info

  end #signup pages


end #User Paged
