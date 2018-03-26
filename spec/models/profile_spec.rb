require "rails_helper"

RSpec.describe Profile, type: :model do
  describe 'profile' do
    it 'belongs to a user' do
      user = FactoryBot.create(:user)
      profile = Profile.new(user: user)
      expect(profile).to be_valid
    end

    it 'is invalid without a user' do
      profile = Profile.new
      expect(profile).not_to be_valid
    end
  end
end
