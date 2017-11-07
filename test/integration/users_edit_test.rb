require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:chris)
  end

  test 'edit with invalid info' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "", email: "email@invalid",
                                              password: "foofoo", password_confirmation: "bar" } }
    assert_template 'users/edit'
    assert_select "div.alert"
  end
end
