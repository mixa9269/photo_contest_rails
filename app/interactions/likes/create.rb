# frozen_string_literal: true

module Likes
  class Create < ActiveInteraction::Base
    object :user
    object :photo

    def execute
      like = photo.likes.create(user_id: user.id)

      errors.merge!(photo.errors) unless like.save

      like
    end
  end
end
