require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  include Devise::TestHelpers                          
  include Warden::Test::Helpers                        
  Warden.test_mode!   

  def teardown                                         
    Warden.test_reset!                                 
  end     

  setup do
    @user = users(:antonija)
    @other_user = users(:pero)
    @post = posts(:one)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: { description: @post.description, user_id: @post.user_id }
    end

    assert_redirected_to root_path
  end

  test "should show post" do
    @post.user_id = @user.id
    get :show, id: @post
    assert_response :success
  end

  test "should update post" do
    patch :update, id: @post, post: { description: @post.description, user_id: @post.user_id }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end

  test "should redirect edit when logged_in as wrong user" do
    sign_in @other_user
    get :edit, id: @post
    assert_redirected_to root_url
  end
end
