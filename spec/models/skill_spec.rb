require 'rails_helper'

RSpec.describe Skill, type: :model do
  let(:skill) {FactoryGirl.create(:skill)}
  
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
        skill.strength = 1.2
        expect(skill).to_not be_valid
      end 
    end

    describe "name" do

      it "must be present" do
        skill.name = ""
        expect(skill).to_not be_valid        
      end

      it "downcases name" do
        skill.name = "jAVascRIPT"
        #TREBAš ponovo stvorit skill
        expect(skill.name).to eq("javascript")
      end
      
      describe "accepts only some values" do
        
        it "doesn't accept any word" do
          skill.name = "kifla"
          expect(skill).to_not be_valid
        end

        it "accepts skill from list" do
          #same list as tag list when creataing new post
        end

      end
    
    end

  end
end