require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:chris)
  end

  test "micropost interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission of posts
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "" } }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    content = "Valid content"
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: { content: content } }
    end
    assert_not flash.empty?
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Post deletion
    assert_select 'a', text: "Delete"
    post_1 = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do 
      delete micropost_path(post_1)
    end
    # Visit different user (no delete links)
    user_2 = users(:lupita)
    get user_path(user_2)
    assert_select 'a', text: "Delete", count: 0
  end

  test "micropost sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.microposts.count.to_s} engagements", response.body
    # User having zero microposts
    user_3 = users(:lupita)
    log_in_as(user_3)
    get root_path
    assert_match "0 engagements", response.body
    user_3.microposts.create!(content: "More than enough")
    get root_path
    assert_match "#{user_3.microposts.count.to_s} engagement", response.body
  end
end
