class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :fullname, :created_at,
             :profile_picture_url, :parent_id

  def fullname
    object.user.name
  end

  def profile_picture_url
    object.user.profile_image
  end
end
