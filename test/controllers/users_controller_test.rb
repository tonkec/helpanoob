require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers                          
  include Warden::Test::Helpers                        
  Warden.test_mode! 

  def setup
    @user = users(:antonija)
  end
  
  test "should get show" do
    sign_in users(:antonija)
    get :show
    assert_response :success
  end

end
