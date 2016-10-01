require 'spec_helper'

describe "User pages" do
  #HOW TO TEST TAGS?
  def sign_in(user)
    visit new_user_session_path
    user.confirm!
    fill_in "user_email",    with: user.email
    fill_in "Password", with: user.password 
    click_button "Sign in"
  end

  before(:each) do

    sign_in user
    visit profile_path

    click_link("Delete your account")  
    #puts "RAILS_ENV is #{Rails.env}"
  end

  describe "Profile page" do
    title = "a" * 50
    description = "desc" * 150
    let(:user) {FactoryGirl.create(:user)}
    let!(:user_post) {FactoryGirl.create(:post, description: description, title: title, user: user)}
    let!(:user_post_2) {FactoryGirl.create(:post, user: user)}
    let!(:user_post_3) {FactoryGirl.create(:post, user: user)}
    let!(:user_post_4) {FactoryGirl.create(:post, user: user)}

    
    let!(:user_skill) {FactoryGirl.create(:skill, user: user)}
    #let!(:user_comment) {FactoryGirl.create(:comment, user: user)}

    it "has right attributes" do

      user_skill.name = "ruby"
      user_skill.save
      #puts user_skill.name
      expect(page).to have_content(user.email)
      expect(page).to have_content(user.username)
      expect(page).to have_content(user_skill.name)
    end

 
  end

  describe "Delete user" do
    let(:user) {FactoryGirl.create(:user)}
    let!(:post) {FactoryGirl.build(:post)}

    it "deletes a user" do
      #save_and_open_page
      expect{click_link "Yes"}.to change(User, :count).by(-1)
      expect(page).to have_css("div.landing-wrapper");
    end

    describe "it deletes associated models" do

      before {click_link "Yes"}
      
      it "deletes user posts" do
        #expect {user.destroy}.to change {Post.count}.by(-1) 
        user_posts = Post.where(user_id: user.id)
        expect(user_posts).to be_empty
      end

      it "deletes user comments" do
        user_comments = Comment.where(user_id: user.id)
        expect(user.comments).to be_empty
      end

      it "deletes user skills" do
        user_skills = Skill.where(user_id: user.id)
        expect(user.skills).to be_empty
      end

    end
  end

  describe "user's skill" do
    let(:user) {FactoryGirl.create(:user)}

    before(:each) do
      find('#add_new_skill').click
    end

    it "accepts only some values" do
      fill_in "Add skill", with: "banana"
      click_button "Create Skill"
      expect(page).to have_content("Pick a real skill")
      expect(page).to have_content("Strength can't be blank!")
      expect(page).to have_content("is not a number")   
    end

    it "creates skill with correct value" do
      fill_in "Add skill", with: "ruby"
      fill_in "Add strength", with: 50
      expect {click_button "Create Skill"}.to change(Skill, :count).by(1)
      expect(page).to have_content("Skill was successfully created.")
    end
  end

    describe "Other user show page" do
      let(:user) {FactoryGirl.create(:user)}
      let(:another_user) {FactoryGirl.create(:user)}
      let!(:another_user_post) {FactoryGirl.create(:post, user: another_user)}
      let!(:another_user_comment) {FactoryGirl.create(:comment, user: another_user)}
      let!(:another_user_skill) {FactoryGirl.build(:skill)}


      before(:each) do
       visit user_path(another_user)
      end

      it "redirects to profile page when visit show page with user id" do
        visit user_path(user)
        #this is how I know I am on the profile page because show page doesnt have settings
        expect(page).to have_content("Settings")
      end

     # it "created post" do
      #  puts "Post #{another_user_post.title}"
       # puts "Skill #{another_user_skill.name}"
       # puts "#{URI.parse(current_url)}"
      #end

      describe "tabs" do
        it "has other user attributes" do
          another_user_skill.save
          expect(page).to have_content(another_user.username)
          expect(page).to have_content(another_user.experience)
          expect(page).to have_content(another_user_skill.name)
        end

        it "has correct tabs" do
          expect(page).to have_css("ul.user-show-tabs")
        end

        it "doesn't have settings tab" do
          expect(page).to_not have_content("Settings")
        end


        describe "Questions tab" do

          before(:each) do
            another_user.save
            find('#user-questions').click
          end 

          it "shows another_user's questions" do
            #puts "user id: #{another_user.id}"
            #puts "User id: #{another_user_post.user.id}"
            #puts "#{another_user_post.title}"
            #puts "#{another_user.posts.first.title}"
            #save_and_open_page
            expect(page).to have_css("h3.post-title")
            expect(page).to have_content("Questions")
            expect(page).to have_content(another_user.username)
            expect(page).to have_content(another_user_post.title)
            expect(page).to_not have_content("Edit")
            expect(page).to_not have_content("Destroy")
          end
        end

        describe "Answers" do
          before(:each) do
            another_user.save
            find('#user-answers').click
          end 
          
          it "shows another_user answers" do
            expect(page).to have_content(another_user_comment.content)
            expect(page).to have_content(another_user_comment.user.username)
            expect(another_user_comment.user.id).to eq(another_user.id) 
            expect(page).to_not have_link("Edit")
            expect(page).to_not have_link("Destroy")
            expect(page).to have_css("i.fa-external-link")
          end

        end

      end     
    end
end