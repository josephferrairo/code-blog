require 'rails_helper'

describe User do
  it 'has many posts' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:post, user: user)
    FactoryBot.create(:post, user: user)

    expect(user.posts.count).to eq(2)
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
end
