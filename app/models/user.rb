class User < ApplicationRecord
  has_secure_password
  has_many :shopping_lists

  validates :email, presence: true, uniqueness: true
end
