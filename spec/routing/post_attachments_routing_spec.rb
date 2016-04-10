require "rails_helper"

RSpec.describe PostAttachmentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/post_attachments").to route_to("post_attachments#index")
    end

    it "routes to #new" do
      expect(:get => "/post_attachments/new").to route_to("post_attachments#new")
    end

    it "routes to #show" do
      expect(:get => "/post_attachments/1").to route_to("post_attachments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/post_attachments/1/edit").to route_to("post_attachments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/post_attachments").to route_to("post_attachments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/post_attachments/1").to route_to("post_attachments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/post_attachments/1").to route_to("post_attachments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/post_attachments/1").to route_to("post_attachments#destroy", :id => "1")
    end

  end
end
