# frozen_string_literal: true

module Comments
  class Create < ActiveInteraction::Base
    integer :user_id
    object :photo
    string :content
    string :parent_id, default: nil

    def to_model
      Comment.new
    end

    def execute
      comment = photo.comments.create(content: content, user_id: user_id, parent_id: parent_id)

      errors.merge!(comment.errors) unless comment.save

      comment
    end
  end
end
