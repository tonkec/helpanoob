require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) {FactoryGirl.build(:user)}
  before { @post = user.posts.build(description: "Lorem ipsum") }

  subject {@post}


  describe "invalid post" do
    
    it "is invalid without description" do
      @post.description = ""
      expect(@post).not_to be_valid
    end

    it "is invalid without title" do
      @post.title = ""
      expect(@post).not_to be_valid
    end

    it "is invalid without user" do
      @post.user_id = ""
      expect(@post).not_to be_valid
    end

    it "is invalid without group" do
      @post.user_id = ""
      expect(@post).not_to be_valid
    end

    #when user deleted his posts are deleted too
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Post.new(user_id: user.id)
      end.to raise_error
    end
  end
  
end