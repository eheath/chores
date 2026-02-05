require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "has many chores" do
    user = users(:first_user)
    assert_includes user.chores, chores(:dishes)
    assert_includes user.chores, chores(:laundry)
  end

  test "has many doers" do
    user = users(:first_user)
    assert_includes user.doers, doers(:alice)
    assert_includes user.doers, doers(:bob)
  end

  test "has many chore trackers" do
    user = users(:first_user)
    assert_includes user.chore_trackers, chore_trackers(:tracker_one)
  end

  test "email is required" do
    user = User.new(password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "password is required" do
    user = User.new(email: "new@example.com")
    assert_not user.valid?
    assert_includes user.errors[:password], "can't be blank"
  end
end
