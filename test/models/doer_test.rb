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
end
