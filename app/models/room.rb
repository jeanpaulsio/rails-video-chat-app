# Holds Video Conference
class Room < ApplicationRecord
  enum status: {
    temporary: 0,
    unrestricted: 1,
    restricted: 2
  }

  validates :name, presence: true, length: { maximum: 15 }
end
