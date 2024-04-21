class Post < ApplicationRecord
  include PostScopes

  belongs_to :category
  belongs_to :user

  has_many :comments, dependent: :destroy

  has_one_attached :attachment_file

  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 10 }

  paginates_per 3
end
