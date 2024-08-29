class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  has_secure_password
  validates :password_digest, presence: true, on: :create
  has_many :orders, dependent: :destroy
end
