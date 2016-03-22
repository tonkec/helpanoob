require 'spec_helper'

describe 'posts/index.html.erb' do
  let(:user) {FactoryGirl.create(:user)}

  def sign_in(user)
    visit new_user_session_path
    user.confirm!
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password 
    click_button "Log in"
  end

  before do
    sign_in user
    visit posts_path
  end

  it "has correct number of posts" do
    expect(page).to have_content("All questions")
    expect(page).to have_content("View More")
    expect(page).to have_css('div.main-post-col', count: 5)
    click_link "View More"
    reload_page
    puts page.body
    #expect {click_link "View More"}.to change(posts_count, :count).by(5)
#          expect {click_button "Ask"}.to_not change(Post, :count).by(1)

  end

end