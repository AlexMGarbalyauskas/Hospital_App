# spec/models/create_user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User creation' do
    it 'is valid with valid attributes' do
      user = User.new(name: "Test User", email: "test@example.com", password: "password123", password_confirmation: "password123")
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = User.new(name: nil, email: "test@example.com", password: "password123", password_confirmation: "password123")
      expect(user).to_not be_valid
    end

    it 'is invalid without an email' do
      user = User.new(name: "Test User", email: nil, password: "password123", password_confirmation: "password123")
      expect(user).to_not be_valid
    end

    it 'is invalid with an invalid email format' do
      user = User.new(name: "Test User", email: "invalid-email", password: "password123", password_confirmation: "password123")
      expect(user).to_not be_valid
    end

    it 'is invalid without a password' do
      user = User.new(name: "Test User", email: "test@example.com", password: nil, password_confirmation: nil)
      expect(user).to_not be_valid
    end

    it 'is invalid with a short password' do
      user = User.new(name: "Test User", email: "test@example.com", password: "short", password_confirmation: "short")
      expect(user).to_not be_valid
    end
  end
end
