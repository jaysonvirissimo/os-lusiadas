# frozen_string_literal: true

Fabricator(:user) do
  email 'dude@mang.com'
  password 'very-long-password'
  password_confirmation 'very-long-password'
  name 'Dude Mang'
end
