require 'spec_helper'

describe "User pages" do

  describe "user show page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:p1) { FactoryGirl.create(:post, user: user, content: "Foo") }
    let!(:p2) { FactoryGirl.create(:post, user: user, content: "Bar") }

    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }

    describe "posts" do
      it { should have_content(p1.content) }
      it { should have_content(p2.content) }
      it { should have_content(user.posts.count) }
    end
  end
end