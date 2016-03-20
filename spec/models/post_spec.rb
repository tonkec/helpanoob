# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  description             :text
#  user_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  group_id                :integer
#  title                   :string
#  image                   :string
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  comments_count          :integer          default(0)
#

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
  let(:post) {user.posts.create(description: "Lorem Content", title: "Title", group_id: 1)}
  let(:comment) {FactoryGirl.create(:comment)}

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
    
    it "when user is destroyed assosicated posts are destroyed too" do
      posts = user.posts
      user_posts = -posts.count
      user.destroy
      posts.each do |p| 
        Post.find_by(p.id).should be_nil
      end

      expect { user.destroy }.to change { Post.count }.by(user_posts)
    end   

    it "destroys asssociated comments" do
      posts_comments = -post.comments.count
      post.destroy
      post.comments.each do |c| 
        Comment.find_by(c.id).should be_nil
      end

      expect { post.destroy }.to change { Comment.count }.by(posts_comments)

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
      click_link "Edit"
      expect(page).to have_css("btn-full")

      fill_in "Title", with: subject.title
      fill_in "post_description", with: subject.description
      click_button
    end

     it "allows correct user to delete post" do
      sign_in user
      visit post_path(subject)
      #save_and_open_page
      expect(page).to have_content(subject.user.email)
      expect(page).to have_content(subject.description)
      expect(page).to have_content(subject.title)
      expect(page).to have_content("Destroy")
     
      #click_link "Destroy"
      #page.accept_confirm { click_button "OK" }
      users_post_id = post.id
      post.delete
      expect(users_post_id).to be_nil

      current_path.should == root_path
      expect(page).to have_content("Post was successfully destroyed")
    end
  end  


end
