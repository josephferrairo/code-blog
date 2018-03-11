require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'A user has many posts' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:post, user: user)
    FactoryBot.create(:post, user: user)

    assert_equal(2, user.posts.count)
  end
end
