# :nodoc:
class User < ApplicationRecord
  has_many :rooms, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  before_validation :set_provider
  before_validation :set_uid

  private

  def set_provider
    self[:provider] = 'email' if self[:provider].blank?
  end

  def set_uid
    self[:uid] = self[:email] if self[:uid].blank? && self[:email].present?
  end
end
