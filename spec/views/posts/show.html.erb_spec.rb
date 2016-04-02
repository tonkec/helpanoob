require 'spec_helper'

describe 'posts/show.html.erb' do
  let(:user) {FactoryGirl.create(:user)}
  let!(:other_user) {FactoryGirl.create(:user)}

  let(:post) {FactoryGirl.create(:post)}
  
  let!(:comment) { FactoryGirl.create(:comment, post: post, user: user) }
  let!(:other_comment) { FactoryGirl.create(:comment, post: post, user: other_user) }
  
  def sign_in(user)
    visit new_user_session_path
    user.confirm!
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password 
    click_button "Log in"
  end

  before do
    sign_in user
    visit post_path(post)
  end

  describe "shows the right post"  do

    it "has post title" do
      expect(page).to have_content(post.title)
    end

    it "has post description" do
      expect(page).to have_content(post.description)
    end

    it "has user's email" do
      expect(page).to have_content(post.user.email)
    end
  end

  describe "shows the right comments" do
    it "has comment content" do
     #save_and_open_page
      expect(page).to have_content(comment.content)
    end

    it "has other_comment's content" do
      expect(page).to have_content(other_comment.content)
    end

    it "has user's email" do
      expect(page).to have_content(comment.user.email)
    end

    it "has other_user's email" do
      expect(page).to have_content(other_comment.user.email)
    end
  end

  describe "allows only right user to edit comment" do
    
  end

  describe "allows only right user to delete comment" do

  end

  describe "does not allow any user to edit comment" do

  end

  describe "does not allow any user to delete comment" do

  end

end