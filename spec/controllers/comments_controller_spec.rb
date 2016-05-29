require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  def sign_in(user)
    visit new_user_session_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    user.confirm!
    click_button "Sign in!"
  end

  let(:pero) {FactoryGirl.create(:user, username: "perek")}
  let(:antonija) {FactoryGirl.create(:user, username: "tonkec_palonkec")}

  let(:antonija_post) {FactoryGirl.create(:post, title: "Antonija's awesome super great post!", user: antonija)}

  let!(:pero_comment) {FactoryGirl.create(:comment, user: pero, post: antonija_post)}

  describe "creating notifications when one user comment on other' user post" do
    before(:each) do
      sign_in pero
      visit post_path(antonija_post)
    end


    describe "notification dropdown" do
    
      it "has right content" do

        fill_in "Say something smart...", with: "say something smart"
        expect { click_button "Comment" }.to change(Notification, :count).by(1)

        find("a[href='#{destroy_user_session_path}']").click

        sign_in antonija
        visit post_path(antonija_post)

        expect(antonija.notifications).to_not be_empty
        expect(page).to have_content("Comment on your question")
        expect(page).to have_css(".dropdown-menu li##{antonija.notifications.first.id}")
        expect(page).to have_css(".panel-body", text: pero.username)
        expect(page).to have_selector("li##{antonija.notifications.first.id}", count: antonija.notifications.count)

        #find(".dropdown-menu li##{antonija.notifications.first.id}").click
        #save_and_open_page
        #expect(antonija.notifications.first.read).to eq(true)

      end


    end #dropdown



  end

end