class User < ApplicationRecord
  EMAIL_REGEX = /.*@.*\..{2,}/ # Extremely simple regex in case user made a typo

  validates :password, length: { minimum: 6 }
  validates :email, format: { with: EMAIL_REGEX }, uniqueness: true, presence: true
  has_secure_password
end
