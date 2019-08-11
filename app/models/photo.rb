# frozen_string_literal: true

class Photo < ApplicationRecord
  include AASM

  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  scope :by_likes, -> { reorder(likes_count: :desc) }
  scope :approved, -> { where(aasm_state: :approved) }
  mount_uploader :photo, PictureUploader
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
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

  def approved?
    aasm_state == 'approved'
  end

  def self.search(search)
    where('title LIKE :search OR location LIKE :search', search: "%#{search}%")
  end

  private

  def photo_size
    errors.add(:photo, 'should be less than 5MB') if photo.size > 5.megabytes
  end
end
