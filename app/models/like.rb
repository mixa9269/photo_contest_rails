# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :photo, counter_cache: true
  belongs_to :user
end
