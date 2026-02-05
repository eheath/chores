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

  test "completed scope returns completed trackers" do
    tracker = chore_trackers(:tracker_one)
    tracker.complete!
    assert_includes ChoreTracker.completed, tracker
    assert_not_includes ChoreTracker.pending, tracker
  end

  test "pending scope returns incomplete trackers" do
    tracker = chore_trackers(:tracker_one)
    assert_includes ChoreTracker.pending, tracker
    assert_not_includes ChoreTracker.completed, tracker
  end

  test "notified scope returns notified trackers" do
    tracker = chore_trackers(:tracker_one)
    tracker.notify!
    assert_includes ChoreTracker.notified, tracker
  end

  test "complete! sets completed_at" do
    tracker = chore_trackers(:tracker_one)
    assert_nil tracker.completed_at
    tracker.complete!
    assert_not_nil tracker.completed_at
  end

  test "notify! sets notified_at" do
    tracker = chore_trackers(:tracker_one)
    assert_nil tracker.notified_at
    tracker.notify!
    assert_not_nil tracker.notified_at
  end

  test "completed? returns true when completed_at is set" do
    tracker = chore_trackers(:tracker_one)
    assert_not tracker.completed?
    tracker.complete!
    assert tracker.completed?
  end

  test "notified? returns true when notified_at is set" do
    tracker = chore_trackers(:tracker_one)
    assert_not tracker.notified?
    tracker.notify!
    assert tracker.notified?
  end
end
