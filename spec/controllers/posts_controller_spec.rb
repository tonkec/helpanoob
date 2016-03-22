# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  description             :text
#  user_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
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
require 'spec_helper'

RSpec.describe PostsController, type: :controller do
 #create #edit #update #delete već imaš u post_spec

 def sign_in(user)
  visit new_user_session_path
  user.confirm!
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password 
  click_button "Log in"
 end

 describe "Posts creation for signed in users" do
  let(:user) {FactoryGirl.create(:user)}

  before do
    sign_in user
    visit new_post_path
  end

  describe "with invalid info" do
    it "does not create a post" do
      visit new_post_path
      puts page.body
      puts current_url
      save_and_open_page
      expect(page).to find("new-q-heading", text: "Feel free to ask anything!")
      too_short_title = "a" * 49
      too_short_description = "a" * 99
      fill_in "post_title", with: too_short_title
      fill_in "Description", with: too_short_description
      expect {click_button "Ask"}.to_not change(Post, :count).by(1)
      expect(page).to have_css('div#error_explanation')
    end
  end

  describe "with invalid info" do
    it "creates post" do
     correct_title = "a" * 50
     correct_description = "a" * 100
     fill_in "Title", with: correct_title
     fill_in "Description", with: correct_description
     select "Group1", :from => "post_group_id"
     expect {click_button "Ask"}.to change(Post, :count).by(1)
     expect(page).to have_current_path(posts_path, only_path: true)  
    end

  end

end

  describe "Posts creation for non signed in users" do
    it "redirects to login page" do
      visit posts_path
      expect(page).to have_current_path(new_user_session_path, only_path: true)
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end

end
