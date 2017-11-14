require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = users(:chris)
    @non_admin = users(:ben)
    @page1_of_users = User.paginate(page: 1)
  end

  test "index as admin including pagination and delete delete links" do
    log_in_as(@admin_user)
    assert @admin_user.activated?
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    @page1_of_users.each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
      assert user.activated?
      unless user == @admin_user
        assert_select "a[href=?]", user_path(user), text: 'Delete account'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    assert @non_admin.activated?
    get users_path
    @page1_of_users.each do |user|
      unless user == @non_admin
        assert_select "a[href=?]", user_path(user), text: user.name
        assert user.activated?
        assert_select 'a[href=?]', user_path(user), text: 'delete', count: 0
      end
    end
  end
end
