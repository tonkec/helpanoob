require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers                          
  include Warden::Test::Helpers                        
  Warden.test_mode! 

  def setup
    @user = users(:antonija)
  end
  
end
