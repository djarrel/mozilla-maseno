require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:chris)
    @other_user = users(:sally)
    log_in_as(@user)
  end

  test "following_page" do
    get following_user_path(@user)
    assert_not @user.following.empty?
    assert_match @user.following.count.to_s, response.body
    @user.following.each do |user|
      assert_select 'a[href=?]', user_path(user)
    end
  end

  test "followers page" do
    get followers_user_path(@user)
    assert_not @user.followers.empty?
    assert_match @user.followers.count.to_s, response.body
    @user.followers.each do |user|
      assert_select 'a[href=?]', user_path(user)
    end
  end

  test "should follow a user the std way" do
    assert_difference 'Relationship.count', 1 do
      post relationships_path, params: { followed_id: @other_user.id }
    end
  end

  test "should follow a user with Ajax" do
    assert_difference 'Relationship.count', 1 do
      post relationships_path, params: { followed_id: @other_user.id, xhr: true }
    end
  end

  test "should unfollow a user the std way" do
    assert_difference 'Relationship.count', -1 do
      delete relationship_path(relationships(:one))
    end
  end

  test "should unfollow a user with Ajax" do
    assert_difference 'Relationship.count', -1 do
      delete relationship_path(relationships(:two))
    end
  end
end

