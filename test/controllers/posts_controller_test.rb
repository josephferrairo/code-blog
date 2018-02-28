require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test 'index will return success' do
    get posts_path
    assert_response :success
  end

  test 'new will return success' do
    get new_post_path
    assert_response :success
  end

  test 'show will return success' do
    post = FactoryBot.create(:post)
    get post_path(post)
    assert_response :success
  end

  test 'edit will return success' do
    post = FactoryBot.create(:post)
    get edit_post_path(post)
    assert_response :success
  end

  test 'successful create request' do
    post_params = { post: { title: 'title', body: 'body' } }
    assert_equal(0, Post.count)

    post posts_path, params: post_params

    post = Post.last
    assert_redirected_to post_path(post)
    follow_redirect!
    assert_response :success

    assert_equal(1, Post.count)
    assert_equal('title', post.title)
    assert_equal('body', post.body)
  end

  test 'should get a successful response back when the params are not valid on create' do
    post_params = { post: { title: '', body: '' } }
    assert_equal(0, Post.count)

    post posts_path, params: post_params

    assert_response :success
    assert_equal(0, Post.count)
  end

  test 'should get a successful update request and not create new posts' do
    post = FactoryBot.create(:post, title: 'title', body: 'body')
    new_post_params = { post: { title: 'new title', body: 'new body' } }
    assert_equal(1, Post.count)

    patch post_path(post), params: new_post_params

    assert_redirected_to post_path(post)
    follow_redirect!
    assert_response :success

    post.reload
    assert_equal(1, Post.count)
    assert_equal('new title', post.title)
    assert_equal('new body', post.body)
  end
end
