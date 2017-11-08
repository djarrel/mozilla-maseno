require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = users(:chris)
    @non_admin = users(:ben)
  end

  test "index as admin including pagination and delete delete links" do
    log_in_as(@admin_user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    page1_of_users = User.paginate(page: 1)
    page1_of_users.each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
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
    get users_path
    assert_select 'a[href=?]', user_path(@admin_user), text: 'delete', count: 0
  end
end
