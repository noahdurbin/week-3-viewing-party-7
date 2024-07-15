require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email)}
    it { should validate_presence_of(:password_digest)}
    it { should have_secure_password }
  end

  it 'can create a user with password' do
    params = {
      name: "Noah",
      email: "noah@testing.com",
      password: "12345678",
      password_confirmation: "12345678"
    }
    noah = User.create(params)

    expect(noah).to_not have_attribute(:password)
    expect(noah.password_digest).to_not eq('12345678')
  end
end
