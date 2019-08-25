# frozen_string_literal: true

module Photos
  class Create < ActiveInteraction::Base
    string :title
    string :location, default: nil
    string :photo_type
    string :vk_image_src, default: nil
    file :photo_file, default: nil
    object :user
    string :remote_photo_url, default: nil
    validates :title, presence: true
    validate(:photo_file || :remote_photo_url)

    def to_model
      Photo.new
    end

    def execute
      photo = user.photos.build(title: title, location: location)
      if photo_type == 'vk'
        photo.remote_photo_url = vk_image_src
      else
        photo.photo = photo_file
      end

      errors.merge!(photo.errors) unless photo.save

      photo
    end
  end
end
