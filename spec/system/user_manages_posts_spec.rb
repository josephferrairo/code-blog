require "rails_helper"

describe 'User Manages Posts' do
  it 'creates a post' do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    visit '/'
    click_link 'Create a New Post'
  end
end
