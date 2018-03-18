require "rails_helper"

describe 'posts' do
  it 'Body and title cannot be blank' do
    post = Post.new
    expect(post).to_not be_valid
    expect(post.errors.messages[:body]).to eq(["can't be blank"])
    expect(post.errors.messages[:title]).to eq(["can't be blank"])
    expect(post.errors.messages[:user]).to eq(["must exist"])
  end

  it 'Creates a valid post' do
    user = FactoryBot.create(:user)
    post = Post.new(title: "this is the title",
                    body: "this is the body",
                    user: user)
    expect(post).to be_valid
  end
end
