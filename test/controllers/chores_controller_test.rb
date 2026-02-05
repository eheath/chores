require "test_helper"

class ChoresControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:first_user)
  end

  test "should get new" do
    get new_chore_url
    assert_response :success
  end

  test "should create chore" do
    assert_difference("Chore.count") do
      post chores_url, params: { chore: { title: "New chore", points: 5 } }, as: :turbo_stream
    end
    assert_response :success
  end

  test "should get edit" do
    get edit_chore_url(chores(:dishes))
    assert_response :success
  end

  test "should update chore" do
    patch chore_url(chores(:dishes)), params: { chore: { title: "Updated title" } }, as: :turbo_stream
    assert_response :success
    assert_equal "Updated title", chores(:dishes).reload.title
  end

  test "should destroy chore" do
    assert_difference("Chore.count", -1) do
      delete chore_url(chores(:dishes)), as: :turbo_stream
    end
    assert_response :success
  end

  test "requires authentication" do
    sign_out users(:first_user)
    get new_chore_url
    assert_response :redirect
  end

  test "cannot edit another users chore" do
    sign_out users(:first_user)
    sign_in users(:second_user)
    get edit_chore_url(chores(:dishes))
    assert_response :not_found
  end

  test "cannot edit deleted chore" do
    chore = Chore.create!(user: users(:first_user), title: "To delete", points: 1, is_deleted: true)
    get edit_chore_url(chore)
    assert_response :not_found
  end
end
