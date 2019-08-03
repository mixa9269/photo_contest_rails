class Photo < ApplicationRecord
  include AASM

  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :photo, PictureUploader
  has_many :likes, dependent: :destroy
  validates :user_id, presence: true, length: { maximum: 128 }
  validates :title, presence: true, length: { maximum: 500 }
  validates :photo, presence: true
  validate  :photo_size

  aasm do
    state :unapproved, initial: true
    state :approved

    event :approve do
      transitions from: :unapproved, to: :approved
    end

    event :unapprove do
      transitions from: :approved, to: :unapproved
    end
  end

  private
    def photo_size
      if photo.size > 5.megabytes
        errors.add(:photo, "should be less than 5MB")
      end
    end
end
