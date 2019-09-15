# frozen_string_literal: true

module Users
  class Update < ActiveInteraction::Base
    string :name
    string :first_name
    string :profile_image
    string :token
    string :secret, default: nil
    object :user

    def execute
      user.update(
        name: name,
        first_name: first_name,
        profile_image: profile_image,
        token: token,
        secret: secret
      )
      user
    end
  end
end
