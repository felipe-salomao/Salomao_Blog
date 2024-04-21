class Category < ApplicationRecord
  include CategoryScopes

  has_many :posts, dependent: :restrict_with_error

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: false }
end
