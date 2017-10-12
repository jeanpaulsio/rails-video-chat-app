# :nodoc:
class Room < ApplicationRecord
  belongs_to :user, optional: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  enum status: {
    temporary:    0,
    unrestricted: 1,
    restricted:   2
  }

  validates :name, presence: true,
                   length: { maximum: 15 },
                   uniqueness: { case_sensitive: false }

  after_create :make_room_public
  before_save  :create_hashed_password, if: :will_save_change_to_password?
  before_save  :update_status,          if: :will_save_change_to_password?
  before_save  :remove_password,        if: :unrestricted?

  def make_room_public
    return if user_id.nil?
    return unless password_is_blank?
    unrestricted!
  end

  def create_hashed_password
    self.password = password_is_blank? ? nil : BCrypt::Password.create(password)
  end

  def check_hashed_password(password_hash)
    BCrypt::Password.new(password_hash)
  end

  def update_status
    self.status = password_is_blank? ? 'unrestricted' : 'restricted'
  end

  def remove_password
    self.password = nil
  end

  def set_default_password
    self.password = BCrypt::Password.create('password')
  end

  private

  def password_is_blank?
    password.blank? || password.nil?
  end
end
