require "test_helper"

class DoersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:first_user)
  end

  test "should get new" do
    get new_doer_url
    assert_response :success
  end

  test "should create doer" do
    assert_difference("Doer.count") do
      post doers_url, params: { doer: { name: "Charlie", phone: "555-9999" } }, as: :turbo_stream
    end
    assert_response :success
  end

  test "should get edit" do
    get edit_doer_url(doers(:alice))
    assert_response :success
  end

  test "should update doer" do
    patch doer_url(doers(:alice)), params: { doer: { name: "Alice Updated" } }, as: :turbo_stream
    assert_response :success
    assert_equal "Alice Updated", doers(:alice).reload.name
  end

  test "requires authentication" do
    sign_out users(:first_user)
    get new_doer_url
    assert_response :redirect
  end

  test "cannot edit another users doer" do
    sign_out users(:first_user)
    sign_in users(:second_user)
    get edit_doer_url(doers(:alice))
    assert_response :not_found
  end

  test "cannot edit deleted doer" do
    doer = Doer.create!(user: users(:first_user), name: "To delete", phone: "555-0000", is_deleted: true)
    get edit_doer_url(doer)
    assert_response :not_found
  end
end
