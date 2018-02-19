# frozen_string_literal: true

Fabricator(:line) do
  stanza { Fabricate(:stanza) }
  number 1
end
