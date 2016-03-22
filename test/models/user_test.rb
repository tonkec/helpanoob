require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:pero)
    @user.password = "password"
  end

  test "name should be present" do
    @user.username = "     "
    assert_not @user.valid?
  end

   test "password should be present" do
    @user.password = "     "
    assert_not @user.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

end
