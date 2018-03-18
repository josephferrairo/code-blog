require "rails_helper"

describe 'User Manages Posts' do
  before (:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end

  it 'creates a post' do
    visit '/'
    click_link 'Create a New Post'
  end
end
