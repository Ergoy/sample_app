require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: 'Rails is awesome!',
                                         email: 'Hello Rails',
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    # assert_same :tag => "div", :attributes => { :id => "error_explanation" }
  end
  # test "valid signup information" do
  #   get signup_path
  #   name     = "Example User"
  #   email    = "[email protected]"
  #   password = "password"
  #   assert_difference 'User.count', 1 do
  #     post_via_redirect users_path, { user: { name: name,
  #                                             email: email,
  #                                             password: password,
  #                                             password_confirmation: password } }
  #   end
  #   assert_template 'users/show'
  # end


end
