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
end
