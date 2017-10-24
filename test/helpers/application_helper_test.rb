require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "full title helper" do
    assert_equal full_title, "Mozilla Maseno"
    assert_equal full_title("Contact"), "Contact | Mozilla Maseno"
  end
end
