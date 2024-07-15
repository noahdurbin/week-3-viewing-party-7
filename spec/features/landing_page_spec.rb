require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "passkey", password_confirmation: "passkey")
    @user2 = User.create(name: "User Two", email: "user2@test.com", password: "passkey", password_confirmation: "passkey")
    visit '/'
  end

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do
    click_button "Create New User"

    expect(current_path).to eq(register_path)

    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end

  it 'lists out existing users' do
    user1 = User.create(name: "User One", email: "user1@test.com", password: "letmein", password_confirmation: "letmein")
    user2 = User.create(name: "User Two", email: "user2@test.com", password: "letmein", password_confirmation: "letmein")

    expect(page).to have_content('Existing Users:')

    within('.existing-users') do
      expect(page).to have_content(@user1.email)
      expect(page).to have_content(@user2.email)
    end
  end

  it 'has a link to log in' do
    visit '/'

    expect(page).to have_link("Log In")

    click_link "Log In"

    expect(current_path).to eq("/login")
  end

  it 'can let an existing user login' do
    user = User.create(name: "Noah", email: "test@test.com", password: "passss", password_confirmation: "passss")

    visit '/login'

    fill_in :email, with: "test@test.com"
    fill_in :password, with: "passss"
    click_button 'Log In'

    expect(current_path).to eq("/users/#{user.id}")
  end
end
