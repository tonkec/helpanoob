require 'rails_helper'

RSpec.describe Skill, type: :model do
  let(:user) {FactoryGirl.create(:user)}
  let!(:skill) {FactoryGirl.build(:skill)}

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

      #it "downcases name" do
       # skill.name = "javaScRipt"
        #skill.save
        #expect(skill.name).to eq("javascript")
      #end
      
    end

  end
end