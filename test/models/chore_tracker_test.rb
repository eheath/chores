require "test_helper"

class ChoreTrackerTest < ActiveSupport::TestCase
  test "belongs to doer" do
    tracker = chore_trackers(:tracker_one)
    assert_equal doers(:alice), tracker.doer
  end

  test "belongs to chore" do
    tracker = chore_trackers(:tracker_one)
    assert_equal chores(:dishes), tracker.chore
  end

  test "belongs to user" do
    tracker = chore_trackers(:tracker_one)
    assert_equal users(:first_user), tracker.user
  end
end
