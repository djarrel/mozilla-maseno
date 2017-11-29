class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  has_attached_file :picture, styles: { medium: "200x200>", thumb: "100x100>" }, default_url: "/images/mes.jpg", storage: :s3
  validates_attachment_size :picture, less_than: 10.megabytes
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
end
