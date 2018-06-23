class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
  has_many :comments

  email_regex = /\A([\w+-].?)+@[a-z\d-]+(.[a-z]+)*.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: email_regex }
  validates :user_name, length: {minimum: 3, message: "must be at least 3 characters."}
  validates :password, length: {minimum: 5, message: "must be at least 5 characters"}, on: :create
end
