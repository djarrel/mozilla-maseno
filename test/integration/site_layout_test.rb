require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:chris)
  end

  test "layout_links" do
    get root_path
    assert_template "static_pages/home"
    assert_select "a[href=?]", root_path, count:2
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", login_path
    get contact_path
    assert_equal full_title("Contact"), "Contact | Mozilla Maseno"
    get about_path
    assert_equal full_title("About"), "About | Mozilla Maseno"
    get signup_path
    assert_equal full_title("Sign up"), "Sign up | Mozilla Maseno"
    get login_path
    assert_equal full_title("Log in"), "Log in | Mozilla Maseno"
    # Behaviour for logged in user
    log_in_as(@user)
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
  end
end
