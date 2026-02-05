require "test_helper"

class ChoreTest < ActiveSupport::TestCase
  test "title is required" do
    chore = Chore.new(user: users(:first_user), points: 1)
    assert_not chore.valid?
    assert_includes chore.errors[:title], "can't be blank"
  end

  test "points is required" do
    chore = Chore.new(user: users(:first_user), title: "Test")
    assert_not chore.valid?
    assert_includes chore.errors[:points], "can't be blank"
  end

  test "belongs to user" do
    chore = chores(:dishes)
    assert_equal users(:first_user), chore.user
  end

  test "has many doers" do
    chore = chores(:dishes)
    assert_respond_to chore, :doers
  end

  test "set_days initializes days to empty array when nil" do
    chore = Chore.new(user: users(:first_user), title: "Test chore", points: 1, days: nil)
    chore.save!
    assert_equal [], chore.days
  end

  test "set_days preserves existing days array" do
    chore = chores(:dishes)
    chore.save!
    assert_equal %w[ Mo We Fr ], chore.days
  end

  test "days_of_week returns expected abbreviations" do
    chore = Chore.new
    assert_equal %w[ Su Mo Tu We Th Fr Sa ], chore.days_of_week
  end

  test "days JSON round-trips correctly" do
    chore = Chore.create!(user: users(:first_user), title: "Round trip", points: 1, days: %w[ Tu Th ])
    chore.reload
    assert_equal %w[ Tu Th ], chore.days
  end

  test "has many doers through chore_trackers" do
    chore = chores(:dishes)
    assert_includes chore.doers, doers(:alice)
  end

  test "active scope excludes deleted chores" do
    chore = chores(:dishes)
    chore.update!(is_deleted: true)
    assert_not_includes Chore.active, chore
    assert_includes Chore.deleted, chore
  end

  test "destroying chore destroys associated chore_trackers" do
    chore = chores(:dishes)
    tracker = chore_trackers(:tracker_one)
    chore.destroy
    assert_not ChoreTracker.exists?(tracker.id)
  end
end
