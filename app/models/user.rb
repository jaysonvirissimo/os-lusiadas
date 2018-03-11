# frozen_string_literal: true

class User < ApplicationRecord
  include Authem::User
  has_deck :words

  validates :name, presence: true
end
