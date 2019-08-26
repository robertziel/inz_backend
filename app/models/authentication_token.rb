class AuthenticationToken < ApplicationRecord
  belongs_to :user

  before_create :set_token

  private

  def set_token
    self.token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(10)
      break token unless self.class.where(token: token).exists?
    end
  end
end
