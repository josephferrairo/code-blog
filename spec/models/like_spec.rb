require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'like' do
    it 'requires a user and post' do
      like = Like.new
      expect(like).to_not be_valid
      expect(like.errors.messages[:user]).to eq(["must exist"])
      expect(like.errors.messages[:post]).to eq(["must exist"])
    end

    it 'creates a valid like' do
      post = FactoryBot.create(:post)
      user = FactoryBot.create(:user)
      like = Like.new(user: user, post: post)
      expect(like).to be_valid
    end

  end
end
