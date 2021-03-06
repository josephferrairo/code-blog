require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET index" do
    it 'will return success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET new' do
    it 'new will return success if a user is logged in' do
      user = FactoryBot.create(:user)
      login_user(user)
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'will redirect a user to the sign_in path if a user is not signed in' do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET show' do
    it 'show will return success' do
      post = FactoryBot.create(:post)
      get :show, params: { id: post.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET edit' do
    it 'edit will return success' do
      user = FactoryBot.create(:user)
      login_user(user)
      post = FactoryBot.create(:post)
      get :edit, params: { id: post.id }
      expect(response).to have_http_status(:success)
    end

    it 'will redirect a user to the sign_in path if a user is not signed in' do
      post = FactoryBot.create(:post)
      get :edit, params: { id: post.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'POST create' do
    it 'creates a new post' do
      user = FactoryBot.create(:user)
      login_user(user)
      expect(Post.count).to eq(0)

      post_params = { post: { title: 'title', body: 'body' } }
      post :create, params: post_params

      post = Post.last
      expect(response).to redirect_to(post_path(post))
      expect(flash[:notice]).to eq('Successfully created post!')

      expect(Post.count).to eq(1)
      expect(post.title).to eq('title')
      expect(post.body).to eq('body')
    end

    it 'cannot create a new post if not logged in ' do
      post_params = { post: { title: 'title', body: 'body' } }
      expect(Post.count).to eq(0)

      post :create, params: post_params

      expect(Post.count).to eq(0)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'PATCH update' do
    it 'should get a successful update request and not create a new post' do
      user = FactoryBot.create(:user)
      login_user(user)
      post = FactoryBot.create(:post, title: 'title', body: 'body', user: user)
      new_post_params = FactoryBot.attributes_for(:post, title: 'new title', body: 'new body')
      expect(Post.count).to eq(1)

      patch :update, params: { id: post.id, post: new_post_params }

      expect(response).to redirect_to(post_path(post))
      post.reload
      expect(Post.count).to eq(1)
      expect(post.title).to eq('new title')
      expect(post.body).to eq('new body')
    end

    it "cannot update another user's posts" do
      user = FactoryBot.create(:user)
      login_user(user)
      post_user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, title: 'title', body: 'body', user: post_user)
      new_post_params = FactoryBot.attributes_for(:post, title: 'new title', body: 'new body')
      expect(Post.count).to eq(1)

      patch :update, params: { id: post.id, post: new_post_params }

      post.reload
      expect(Post.count).to eq(1)
      expect(post.title).to eq('title')
      expect(post.body).to eq('body')
    end
  end

  describe 'destroy' do
    it 'will destroy its own post' do
      user = FactoryBot.create(:user)
      login_user(user)
      post = FactoryBot.create(:post, user: user)
      expect(Post.count).to eq(1)
      post_params =  { id: post.id }

      expect { delete :destroy, params: post_params }.to change(Post, :count).by(-1)
    end

    it "cannot destroy someone else's like" do
      user = FactoryBot.create(:user)
      other_user = FactoryBot.create(:user)
      login_user(user)
      post = FactoryBot.create(:post, user: other_user)
      expect(Post.count).to eq(1)

      expect { delete :destroy, params: { id: post.id} }.to change(Post, :count).by(0)
      expect(flash[:alert]).to eq("You cannot delete other people's posts")
    end

    it 'needs to be signed in' do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      expect(Post.count).to eq(1)

      expect { delete :destroy, params: { id: post.id} }.to change(Post, :count).by(0)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
