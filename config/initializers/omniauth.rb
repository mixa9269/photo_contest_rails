# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, ENV['VK_KEY'], ENV['VK_SECRET'], scope: %w[photos offline], setup: true
end
