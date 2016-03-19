require 'rails_helper'

RSpec.describe Post, type: :model do

  def sign_in(user)
    visit new_user_session_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    user.confirm!
    click_button "Log in"
  end

  let(:user) {FactoryGirl.create(:user)}
  let(:other_user) {FactoryGirl.create(:user)}
  let(:post) {FactoryGirl.create(:post)}
  #KAK ZNA KOJI JE ČIJI POST????????????????????

  subject {post}

  describe "invalid post" do

    it "is invalid without description" do

      subject.description = ""
      expect(subject).not_to be_valid
    end

    it "is invalid without title" do
      subject.title = ""
      expect(subject).not_to be_valid
    end

    it "is invalid without user" do
      subject.user_id = ""
      expect(subject).not_to be_valid
    end

    it "is invalid without group" do
      subject.group_id = ""
      expect(subject).not_to be_valid
    end

  end

  describe "post associations" do

    before { user.save }
    
    it "destroys assosicated posts" do
      posts = user.posts
      user_posts = -posts.count
      user.destroy
      posts.each do |p| 
        Post.find_by(p.id).should be_nil
      end

      expect { user.destroy }.to change { Post.count }.by(user_posts)
    end   
  end

  describe "Authorization" do

    it "doesn't allow any user to edit or delete post" do
      sign_in other_user
      visit post_path(subject)
      expect(page).to_not have_link("Edit")
      expect(page).to_not have_link("Delete")
    end

    it "allows correct user to edit post" do
      sign_in user
      visit post_path(subject)
      expect(page).to have_link("Edit")
      expect(page).to have_css("post-editable-links")
      click_link "Edit"
    end

     it "allows correct user to delete post" do
      sign_in user
      visit post_path(subject)
      save_and_open_page
      expect(page).to have_css("delete_post")
      expect(page).to have_css("main-question-icon")
      expect(page).to have_css("post-editable-links")
      expect(page).to have_link(subject.user.email)
      expect(page).to have_content(subject.description)
      expect(page).to have_content(subject.title)
      expect(page).to have_content("Destroy")
     
      click_link "Destroy"
      page.accept_confirm { click_button "OK" }
      expect(Post.count).to change_by(-1)
    end
  end  


end