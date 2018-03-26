require "rails_helper"

RSpec.describe 'User Likes and Unlikes Posts', type: :system do
  it 'likes a post' do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post)
    login_as(user, scope: :user)
    visit '/posts'
    expect(Like.count).to eq(0)

    find("a[href='#{post_likes_path(post)}']").click
    expect(Like.count).to eq(1)
  end

  it 'unlikes a post' do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post)
    like = FactoryBot.create(:like, post: post, user: user)
    login_as(user, scope: :user)
    visit '/posts'
    expect(Like.count).to eq(1)

    find("a[href='#{post_like_path(post, user)}']").click
    expect(Like.count).to eq(0)
  end
end
