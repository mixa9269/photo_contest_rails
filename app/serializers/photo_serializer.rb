# frozen_string_literal: true

class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :title, :location, :author, :likes_count, :comments_count

  def author
    object.user
  end
end
