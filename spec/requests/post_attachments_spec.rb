require 'rails_helper'

RSpec.describe "PostAttachments", type: :request do
  describe "GET /post_attachments" do
    it "works! (now write some real specs)" do
      get post_attachments_path
      expect(response).to have_http_status(200)
    end
  end
end
