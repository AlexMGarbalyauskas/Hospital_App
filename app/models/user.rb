# app/models/user.rb

# User model representing users of the application
class User < ApplicationRecord

  # password handling
  has_secure_password

  # Validations
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :password, length: { minimum: 6 }, if: :password_digest_changed?
  validates :name, presence: true
end
