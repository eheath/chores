require "test_helper"
require 'byebug'

class ChoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'title is required' do
    chore = Chore.new(user: users(:first_user))
    assert_not chore.valid?
    chore.title = "foo bar"
    assert chore.valid?
  end
end
