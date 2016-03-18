require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) {FactoryGirl.build(:post)}

  describe "invalid post" do
    
    it "is invalid without description" do
      post.description = ""
      expect(post).not_to be_valid
    end

    it "is invalid without title" do
      post.title = ""
      expect(post).not_to be_valid
    end

    it "is invalid without user" do
      post.user_id = ""
      expect(post).not_to be_valid
    end

    it "is invalid without group" do
      post.user_id = ""
      expect(post).not_to be_valid
    end

    #when user deleted his posts are deleted too
  end

  
end