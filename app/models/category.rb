class Category < ApplicationRecord
  has_many :posts, dependent: :restrict_with_error

  validates :name, presence: true, length: { minimum: 3 }

  scope :sorted, -> { order(:name) }
end
