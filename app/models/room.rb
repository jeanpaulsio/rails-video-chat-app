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

  after_create :update_status
  before_save  :create_hashed_password, if: :will_save_change_to_password?

  def update_status
    return if user_id.nil?
    unrestricted!
  end

  def create_hashed_password
    self.password = BCrypt::Password.create(password)
  end
end
