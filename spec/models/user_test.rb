require 'rails_helper'

describe 'User' do
  it 'A user has many posts' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:post, user: user)
    FactoryBot.create(:post, user: user)

    expect(user.posts.count).to eq(2)
  end
end
