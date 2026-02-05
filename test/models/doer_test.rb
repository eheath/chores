require "test_helper"

class DoerTest < ActiveSupport::TestCase
  test "belongs to user" do
    doer = doers(:alice)
    assert_equal users(:first_user), doer.user
  end

  test "has many chore trackers" do
    doer = doers(:alice)
    assert_includes doer.chore_trackers, chore_trackers(:tracker_one)
  end

  test "has many chores through chore_trackers" do
    doer = doers(:alice)
    assert_includes doer.chores, chores(:dishes)
  end

  test "name is required" do
    doer = Doer.new(user: users(:first_user), phone: "555-0000")
    assert_not doer.valid?
    assert_includes doer.errors[:name], "can't be blank"
  end

  test "phone is required" do
    doer = Doer.new(user: users(:first_user), name: "Test")
    assert_not doer.valid?
    assert_includes doer.errors[:phone], "can't be blank"
  end

  test "active scope excludes deleted doers" do
    doer = doers(:alice)
    doer.update!(is_deleted: true)
    assert_not_includes Doer.active, doer
    assert_includes Doer.deleted, doer
  end

  test "destroying doer destroys associated chore_trackers" do
    doer = doers(:alice)
    tracker = chore_trackers(:tracker_one)
    doer.destroy
    assert_not ChoreTracker.exists?(tracker.id)
  end
end
