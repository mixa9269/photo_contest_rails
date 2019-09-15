# frozen_string_literal: true

class User < ApplicationRecord
  has_many :photos, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_photos, through: :likes, source: :photo

  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
    Users::Update.run(params_update(auth_hash, user))
  end

  def liked?(photo)
    liked_photos.include?(photo)
  end

  def self.params_update(auth_hash, user)
    {
      name: auth_hash.info.name,
      first_name: auth_hash.info.first_name,
      profile_image: auth_hash.info.image,
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret,
      user: user
    }
  end
end
