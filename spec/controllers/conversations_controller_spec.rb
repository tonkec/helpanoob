require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #get_mailbox" do
    it "returns http success" do
      get :get_mailbox
      expect(response).to have_http_status(:success)
    end
  end

end
