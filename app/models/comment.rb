class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :content, length: {minimum: 1, message:"must be at least 1 character."}
end
