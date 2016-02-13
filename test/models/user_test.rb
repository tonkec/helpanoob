require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:pero)
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
    puts @user.errors.full_messages
  end

end
