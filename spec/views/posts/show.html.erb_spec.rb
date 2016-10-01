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
    click_button "Sign in!"
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

    it "has user's username" do
      expect(page).to have_content(post.user.username)
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

    it "has user's username" do
      expect(page).to have_content(comment.user.username)
    end

    it "has other_user's username" do
      expect(page).to have_content(other_comment.user.username)
    end
  end

  describe "allows only right user to edit comment" do
    
    it "has link to edit" do
      expect(page).to have_css("span.edit-icon")
      expect(page).to have_link(nil, href: edit_post_comment_path(post, comment))
    end
  
  end

  describe "allows only right user to delete comment" do
    let(:delete) { page.find(:link, nil, [comment.post, comment])}

    it "has link to delete" do
      expect(page).to have_css("span.delete-icon")
      expect(page).to have_link(nil, href: [comment.post, comment])
    end

    it "deletes the comment" do
      expect { click_link delete }.to change(Comment, :count).by(-1)
    end
  
  end

  describe "does not allow any user to edit comment" do
    it "does not have link to edit" do
      expect(page).to_not have_link("Edit", edit_post_comment_path(post, other_comment))
    end
  end

  describe "does not allow any user to delete comment" do
    
  end

end