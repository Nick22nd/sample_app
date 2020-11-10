require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup infomation" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: {
        user: {
          name: "",
          email: "user@vip.com",
          password: "foo",
          password_confirmation: "bar"
        }
      }
    end
    assert_template "users/new"
  end
  test "valid signup infomation" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: {
        user: {
          name: "root",
          email: "user@vip.com",
          password: "foodddd",
          password_confirmation: "foodddd"
        }
      }
    end
    follow_redirect!
    assert_template "users/show"
    assert_not flash[:success].blank?
  end
end
