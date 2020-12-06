class User < ApplicationRecord
  # passwordをbcryptでハッシュ化してpassword_digestに入れるために必要
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  has_many :microposts, dependent: :destroy
end
