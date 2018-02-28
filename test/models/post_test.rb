require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'Body and title cannot be blank' do
    post = Post.new
    assert(post.invalid?)
    assert_equal(["can't be blank"], post.errors.messages[:body])
    assert_equal(["can't be blank"], post.errors.messages[:title])
  end

  test 'Creates a valid post' do
    post = Post.new(title: "this is the title", body: "this is the body")
    assert(post.valid?)
  end
end
