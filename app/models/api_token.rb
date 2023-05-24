class ApiToken < ApplicationRecord
  belongs_to :user

  before_create :set_default_values

  scope :valid, -> { where(expires_at: Time.current..) }

  private

  def set_default_values
    self.token = SecureRandom.hex
    self.expires_at ||= 1.month.from_now
  end
end
