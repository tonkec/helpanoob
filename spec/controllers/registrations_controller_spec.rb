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
        
        find('#user_avatar', visible: false).set user.avatar
        attach_file('user_avatar', user.avatar)
        fill_in "user_avatar", with: user.avatar

        click_button "Sign up"
      end

      it "shows message about confirmation email" do
        expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please open the link to activate your account.")
      end

    describe "confirmation email" do
      # Include email_spec modules here, not in rails_helper because they
      # conflict with the capybara-email#open_email method which lets us
      # call current_email.click_link below.
      # Re: https://github.com/dockyard/capybara-email/issues/34#issuecomment-49528389
      include EmailSpec::Helpers
      include EmailSpec::Matchers

      # open the most recent email sent to user_email
      subject { open_email(user_email) }

      # Verify email details
      it { is_expected.to deliver_to(user_email) }
      it { is_expected.to have_body_text(/You can confirm your account/) }
      it { is_expected.to have_body_text(/users\/confirmation\?confirmation/) }
      it { is_expected.to have_subject(/Confirmation instructions/) }
    end

    context "when clicking confirmation link in email" do
      before :each do
        open_email(user_email)
        current_email.click_link 'Confirm my account'
      end
    end

      
    end #valid info

  end #signup pages


end #User Paged
