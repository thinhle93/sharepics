class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100#"}
  validates_attachment_presence :image
  validates :description, length: {minimum: 2, message:"must be at least 2 characters."}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end