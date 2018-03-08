# frozen_string_literal: true

class User < ApplicationRecord
  include Authem::User

  validates :name, presence: true
end
