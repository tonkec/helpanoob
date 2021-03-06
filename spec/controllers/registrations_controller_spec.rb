require 'rails_helper'
require 'spec_helper'

describe "User Registration" do

  subject { FactoryGirl.build(:user) }

  describe "non signed up users" do

    it "redirects to Signin page" do
      visit(root_path)
      visit(posts_path)
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end

  end

  describe "signup page" do
    before { visit new_user_registration_path }
    let(:submit) { "Let's do it!" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end #it
    end #invalid info

    describe "with valid information" do
      before do
        fill_in "Username", with: subject.username
        fill_in "Email",        with: subject.email
        fill_in "Password",     with: subject.password
        fill_in "Confirm password", with: subject.password_confirmation
        attach_file('user_avatar', File.join(Rails.root, '/spec/fixtures/files/sweal.jpg'))
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      it "shows message about confirmation email" do
        click_button submit
        expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.")
        #puts subject.confirmation_token
        #expect(subject.introduction).to_not be_nil
      end

      describe "user not activated" do
      
        it "is not activated" do
          subject.confirmed?.should eq(false)
        end

        it "should not be able to access posts page when not activated" do
          visit posts_path
          save_and_open_page
          #expect(page).to have_content("Sign in!")
          expect(page).to have_content("You need to sign in or sign up before continuing.")
        end

        it "should not be able to access post page" do
          firstPost = Post.first
          visit post_path(firstPost)
          #expect(page).to have_link("Sign in")
          expect(page).to have_content("You need to sign in or sign up before continuing.")
        end

        it "should not be able to access user page" do
          firstUser = User.first
          visit user_path(firstUser)
          #expect(page).to have_link("Sign in")
          expect(page).to have_content("You need to sign in or sign up before continuing.")
        end
      end  

    end #valid info


  end #signup pages

end #User Paged
