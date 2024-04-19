class User < ApplicationRecord
  rolify
  has_many :posts, dependent: :destroy

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable

  devise :confirmable, :database_authenticatable, :registerable,
         :trackable, :recoverable, :rememberable, :validatable
end
