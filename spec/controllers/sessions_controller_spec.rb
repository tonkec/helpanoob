require 'rails_helper'

describe "User Authentication" do

  def set_host (host)
    # host! host
    default_url_options[:host] = host
    Capybara.app_host = "http://" + host
  end

  subject { page }

  before(:each) do
    set_host "localhost:3000"
  end

  describe "signin page" do
    before { visit new_user_session_path }
    let(:submit) { "Log In" }

    describe "log in" do
      before { visit new_user_session_path }

      describe "with invalid information" do 
        before { click_button "Log in" }
        it { should have_selector(:link_or_button, 'Log in') }
      end #invalif

      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          user.confirm!
          click_button "Log in"
        end

        it "redirects to root path after sign in" do
          
          expect(page).to have_current_path(root_path, only_path: true)

          expect(page).to have_link('Log out', href: destroy_user_session_path)
          expect(page).to have_link('Questions', href: posts_path)
          expect(page).to have_link('Profile', href: profile_path)
          expect(page).to_not have_link('Log in', href: new_user_session_path)

        end #it

        it "redirects logout to root" do
          click_link "Log out"
          expect(page).to have_content('Log in')
        end


      end #with valid

    end #log in
  end #signin

  

end #user authentication