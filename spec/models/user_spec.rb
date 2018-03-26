require 'rails_helper'

describe User do
  describe 'User attributes / validations' do
    it 'has many posts' do
      user = FactoryBot.create(:user)
      FactoryBot.create(:post, user: user)
      FactoryBot.create(:post, user: user)

      expect(user.posts.count).to eq(2)
    end

    it 'creates a blank profile when the user is created' do
      user = FactoryBot.create(:user)
      expect(user.profile).not_to be_nil
    end

    it 'has_one profile' do
      user = FactoryBot.create(:user)
      profile = FactoryBot.create(:profile, user: user)
      expect(profile.user).to eq(user)
    end

    it 'creates a valid user' do
      user = User.new(first_name: 'John',
                      last_name: 'Smith',
                      email: 'kanye@kanye.gov',
                      password: 'password')
      expect(user).to be_valid
    end

    it 'validates the presence of first_name and last name' do
      user = User.new(email: 'kanye@kanye.gov',
                      password: 'password')

      expect(user).not_to be_valid
      expect(user.errors.messages[:first_name]).to eq(["can't be blank"])
      expect(user.errors.messages[:last_name]).to eq(["can't be blank"])
    end

    describe 'full_name' do
      it 'will return the full name' do
        user = FactoryBot.create(:user, first_name: 'Joe', last_name: 'Smith')
        expect(user.full_name).to eq('Joe Smith')
      end
    end

    describe 'liked?' do
      it 'will return the post if a user liked it' do
        user = FactoryBot.create(:user)
        post = FactoryBot.create(:post)
        like = FactoryBot.create(:like, user: user, post: post)

        expect(user.liked?(post)).to eq(like)
      end

      it 'will return nil if a user did not like a post' do
        user = FactoryBot.create(:user)
        post = FactoryBot.create(:post)

        expect(user.liked?(post)).to eq(nil)
      end
    end
  end
end
