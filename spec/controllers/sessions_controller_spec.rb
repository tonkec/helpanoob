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
    let(:submit) { "Sign in" }

    describe "Sign in" do
      before { visit new_user_session_path }

      describe "with invalid information" do 
        before { click_button "Sign in" }
        it { should have_selector(:link_or_button, 'Sign in') }
      end #invalif

      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          user.confirm!
          click_button "Sign in"
        end

        it "redirects to root path after sign in" do
          
          expect(page).to have_current_path(root_path, only_path: true)
          save_and_open_page

          expect(page).to have_selector(:css, 'a[href="/profile"]')          
          expect(page).to have_selector(:css, 'a[href="/users/sign_out"]')          
          expect(page).to have_selector(:css, 'a[href="/posts"]')          
          expect(page).to have_selector(:css, 'a[href="/about"]')          
          expect(page).to_not have_link('Sign in', href: new_user_session_path)

        end #it

        it "redirects logout to root" do
          find(:xpath, "//a[@href='/users/sign_out']").click
          expect(page).to have_content('Sign In!')
        end


      end #with valid

    end #Sign in
  end #signin

  

end #user authentication