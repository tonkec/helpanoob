require 'rails_helper'

RSpec.describe Skill, type: :model do
  let(:user) {FactoryGirl.create(:user)}
  let(:skill) {FactoryGirl.create(:skill)}

  def sign_in(user)
    visit new_user_session_path
    user.confirm!
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password 
    click_button "Log in"
  end
  
  describe "basic validations" do
    it "is valid" do
      expect(skill).to be_valid
    end
    
    describe "strength" do

      it "must be present" do
        skill.strength = ""
        expect(skill).to_not be_valid        
      end

      it "allows only positive numberh" do
        skill.strength = -1
        expect(skill).to_not be_valid
      end 

      it "allows only numbers less than 100" do
        skill.strength = 101
        expect(skill).to_not be_valid
      end

      it "allows only floats" do
        skill.strength = 0.5
        expect(skill.strength).to eq(0)
      end 
    end

    describe "name" do

      it "must be present" do
        skill.name = ""
        expect(skill).to_not be_valid        
      end

      it "downcases name" do
        skill.name = "jAVascRIPT"
        skill.save
        expect(skill.name).to eq("javascript")
      end
      
      describe "accepts only some values" do

        before do
          sign_in user
          visit new_user_skill_path(user, skill)
          #save_and_open_page
          fill_in "Add number", with: skill.strength
        end

        it "doesn't accept any word" do
          fill_in "Add skill", with: "banana"
          expect do
            click_button "Create Skill"
          end.to change(Skill, :count).by(0)

          expect(page).to have_content("Create Skill")
        end

        it "accepts skill from list" do
          fill_in "Add skill", with: "php"
          expect do
            click_button "Create Skill"
          end.to change(Skill, :count).by(1)
        end

        it "downcases the skill" do
          fill_in "Add skill", with: "RUBY ON RAILS"
          expect do
            click_button "Create Skill"
          end.to change(Skill, :count).by(1)
        end

      end
    
    end

  end
end