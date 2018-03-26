require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  describe 'POST create' do
    it 'will create a like' do
      user = FactoryBot.create(:user)
      post1 = FactoryBot.create(:post)

      login_user(user)
      expect(Like.count).to eq(0)

      like_params = {  post_id: post1.id, user_id: user.id }
      post :create, params: like_params

      like = Like.last
      expect(Like.count).to eq(1)
      expect(like.user).to eq(user)
      expect(like.post).to eq(post1)
    end
  end

  describe 'destroy' do
    it 'will destroy its own like' do
      user = FactoryBot.create(:user)
      login_user(user)
      post1 = FactoryBot.create(:post)
      like = FactoryBot.create(:like, user: user, post: post1)
      expect(Like.count).to eq(1)

      expect { delete :destroy, params: { post_id: post1.id, user: user.id, id: like.id} }.to change(Like, :count).by(-1)
    end

    it "cannot destroy someone else's like" do
      user = FactoryBot.create(:user)
      other_user = FactoryBot.create(:user)
      login_user(user)
      post1 = FactoryBot.create(:post)
      like = FactoryBot.create(:like, user: other_user, post: post1)
      expect(Like.count).to eq(1)

      expect { delete :destroy, params: { post_id: post1.id, user: user.id, id: like.id} }.to change(Like, :count).by(0)
      expect(flash[:alert]).to eq('That is not your like to delete!')
    end
  end
end
