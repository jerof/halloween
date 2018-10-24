class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_attached_file :image, styles: { image_index: "350x250>", image_show: "560x400>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  acts_as_votable
end
