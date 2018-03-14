# frozen_string_literal: true

Fabricator(:line) do
  absolute_number { sequence(:absolute_number, 1) }
  stanza { Fabricate(:stanza) }
  number 1
end
