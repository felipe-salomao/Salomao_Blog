class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :body, presence: true

  enum anonymous: {
    inactive: 0,
    active: 1
  }

  def anonymous=(value)
    self[:anonymous] = value.to_i
  end
end
