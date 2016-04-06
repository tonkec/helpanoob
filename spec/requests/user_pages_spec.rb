require 'spec_helper'

describe "User pages" do
  #HOW TO TEST TAGS?
  def sign_in(user)
    visit new_user_session_path
    user.confirm!
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password 
    click_button "Log in"
  end

  before(:each) do
    sign_in user
    page.visit "/profile"

   
    click_link("Delete your account")  
#    puts "RAILS_ENV is #{Rails.env}"
  end

  describe "Profile page" do
    title = "a" * 50
    description = "desc" * 150
    let(:user) {FactoryGirl.create(:user)}
    let!(:user_post) {FactoryGirl.create(:post, description: description, title: title, user: user)}
    let!(:user_post_2) {FactoryGirl.create(:post, user: user)}
    let!(:user_post_3) {FactoryGirl.create(:post, user: user)}
    let!(:user_post_4) {FactoryGirl.create(:post, user: user)}

    
    let!(:user_skill) {FactoryGirl.build(:skill, user: user)}
    let!(:user_comment) {FactoryGirl.create(:comment, user: user)}

    it "has right attributes" do
      user_skill.save
      expect(page).to have_content(user.email)
      expect(page).to have_content(user.username)
      expect(page).to have_content(user_skill.name)
    end

    

    describe "View more on questions tab" do
      puts "zakaj se ovi postovi ne sejvaju?"
      before {find("a#qquestions").click}
      it "has view more button" do

        save_and_open_page
        puts "#{user.posts.count}"
        click_button "View More"
      end
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
      click_link("Add new skill")
    end

    it "creates new skill" do
      expect do
        click_button "Create Skill"
      end.to change(Skill, :count).by(0)
    end

    it "accepts only some values" do
      fill_in "Add skill", with: "banana"
      click_button "Create Skill"
      expect(page).to have_content("Pick a real skill")
      expect(page).to have_content("Strength can't be blank!")
      expect(page).to have_content("is not a number")   
      expect(page).to have_css("div#error_explanation")
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
            expect(page).to have_css("h3.post-title")
            expect(page).to have_content("Questions")
            expect(page).to have_content(another_user.email)
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
           # save_and_open_page
            expect(page).to have_content(another_user_comment.content)
            expect(page).to have_content(another_user_comment.user.email)
            expect(another_user_comment.user.id).to eq(another_user.id) 
            expect(page).to_not have_link("Edit")
            expect(page).to_not have_link("Destroy")
            expect(page).to have_link("See post", href: post_path(another_user_comment.post))
          end

        end

      end     
    end

end