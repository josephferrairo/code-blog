require "rails_helper"

FactoryBot.describe Post do
  describe 'post' do
    it 'cannot have a blank body, title, or user' do
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

    describe 'like_count' do
      it 'will return the amount of likes a post has' do
        post = FactoryBot.create(:post)

        3.times do
          FactoryBot.create :like, post: post
        end

        expect(post.likes.count).to eq(3)
      end
    end
  end
end
