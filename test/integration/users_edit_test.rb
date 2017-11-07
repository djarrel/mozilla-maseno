require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:chris)
  end

  test 'edit with invalid info' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "", email: "email@invalid",
                                              password: "foofoo", password_confirmation: "bar" } }
    assert_template 'users/edit'
    assert_select "div.alert" 
  end

  test "edit with valid info" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Valid Name"
    email = "valid@email.com"
    patch user_path(@user), params: { user: { name: name, email: email,
                                              password: "", password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
