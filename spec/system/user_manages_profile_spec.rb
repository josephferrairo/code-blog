require "rails_helper"

RSpec.describe 'User Manages Biography', type: :system do
  it 'updates their biography' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:profile, user: user)
    login_as(user, scope: :user)
    visit '/'
    click_link 'Edit your profile'

    profile = user.profile
    expect(Profile.count).to eq(1)
    expect(page).to have_content(profile.biography)
    expect(find_field('Web browser').value).to have_content(profile.web_browser)
    expect(find_field('Text editor').value).to eq(profile.text_editor)
    expect(find_field('Terminal').value).to eq(profile.terminal)
    fill_in 'Web browser', with: 'Chrome'
    fill_in 'Text editor', with: 'vim'
    fill_in 'Terminal', with: 'iterm2'
    fill_in_trix_editor('This is my Biography')
    click_button 'Update Profile'

    profile.reload
    expect(Profile.count).to eq(1)
    expect(strip_html(profile.biography)).to eq('This is my Biography')
    expect(profile.web_browser).to eq('Chrome')
    expect(profile.text_editor).to eq('vim')
    expect(profile.terminal).to eq('iterm2')
    expect(page).to have_content(strip_html(profile.biography))
    expect(page).to have_content(profile.web_browser)
    expect(page).to have_content(profile.text_editor)
    expect(page).to have_content(profile.terminal)
  end

  def fill_in_trix_editor(text="Added Text")
    execute_script("document.querySelector('trix-editor').editor.loadHTML('')")
    execute_script("document.querySelector('trix-editor').editor.insertString('#{text}')")
  end

  def strip_html(string)
    Nokogiri::HTML(string).text
  end
end
