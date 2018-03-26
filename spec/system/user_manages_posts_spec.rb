require "rails_helper"

RSpec.describe 'User Manages Posts', type: :system do
  it 'creates a post' do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    visit '/'
    click_link 'Create a New Post'
    expect(Post.count).to eq(0)
    fill_in 'Title', with: 'Title'
    fill_in_trix_editor('Body')

    click_button 'Create Post'

    expect(Post.count).to eq(1)
    post = Post.last
    expect(post.title).to eq('Title')
    expect(strip_html(post.body)).to eq('Body')
    expect(page).to have_content(post.title)
    expect(page).to have_content(strip_html(post.body))
  end
end
