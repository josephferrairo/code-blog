require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe "GET index" do
    it 'will return success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET show' do
    it 'show will return success' do
      profile = FactoryBot.create(:profile)
      get :show, params: { id: profile.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET edit' do
    it 'edit will return success when signed in' do
      user = FactoryBot.create(:user)
      login_user(user)
      profile = FactoryBot.create(:profile)
      get :edit, params: { id: profile.id }
      expect(response).to have_http_status(:success)
    end

    it 'will redirect a user to the sign_in path if a user is not signed in' do
      profile = FactoryBot.create(:profile)
      get :edit, params: { id: profile.id }
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
    end
  end

  describe 'PATCH update' do
    it 'should get a successful update request and not create a new profile' do
      user = FactoryBot.create(:user)
      login_user(user)
      profile = FactoryBot.create(:profile,
                                  user: user,
                                  biography: 'I did a thing',
                                  web_browser: 'Chrome',
                                  text_editor: 'Vim',
                                  terminal: 'terminal')

      new_profile_params = FactoryBot.attributes_for(:profile,
                                                     biography: 'I did another thing',
                                                     web_browser: 'Firefox',
                                                     text_editor: 'Neovim',
                                                     terminal: 'iterm2'
                                                    )
      expect(Profile.count).to eq(1)

      patch :update, params: { id: profile.id, profile: new_profile_params }

      profile.reload
      expect(flash[:notice]).to eq('Successfully updated your profile!')
      expect(Profile.count).to eq(1)
      expect(profile.biography).to eq('I did another thing')
      expect(profile.web_browser).to eq('Firefox')
      expect(profile.text_editor).to eq('Neovim')
      expect(profile.terminal).to eq('iterm2')
    end

    it "cannot update another user's profile" do
      profile_user = FactoryBot.create(:user)
      user = FactoryBot.create(:user)
      login_user(user)
      profile = FactoryBot.create(:profile,
                                  user: profile_user,
                                  biography: 'I did a thing',
                                  web_browser: 'Chrome',
                                  text_editor: 'Vim',
                                  terminal: 'terminal')

      new_profile_params = FactoryBot.attributes_for(:profile,
                                                     biography: 'I did another thing',
                                                     web_browser: 'Firefox',
                                                     text_editor: 'Neovim',
                                                     terminal: 'iterm2')
      expect(Profile.count).to eq(1)

      patch :update, params: { id: profile.id, profile: new_profile_params }

      profile.reload
      expect(Profile.count).to eq(1)
      expect(profile.biography).to eq('I did a thing')
      expect(profile.web_browser).to eq('Chrome')
      expect(profile.text_editor).to eq('Vim')
      expect(profile.terminal).to eq('terminal')
      expect(flash[:alert]).to eq('This is not you!')
    end

    it 'must be logged in' do
      profile_user = FactoryBot.create(:user)
      profile = FactoryBot.create(:profile,
                                  user: profile_user,
                                  biography: 'I did a thing',
                                  web_browser: 'Chrome',
                                  text_editor: 'Vim',
                                  terminal: 'terminal')

      new_profile_params = FactoryBot.attributes_for(:profile,
                                                     biography: 'I did another thing',
                                                     web_browser: 'Firefox',
                                                     text_editor: 'Neovim',
                                                     terminal: 'iterm2')
      expect(Profile.count).to eq(1)

      patch :update, params: { id: profile.id, profile: new_profile_params }
      assert_redirected_to new_user_session_path

      profile.reload
      expect(Profile.count).to eq(1)
      expect(profile.biography).to eq('I did a thing')
      expect(profile.web_browser).to eq('Chrome')
      expect(profile.text_editor).to eq('Vim')
      expect(profile.terminal).to eq('terminal')
    end
  end
end
