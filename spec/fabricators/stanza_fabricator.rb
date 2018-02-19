# frozen_string_literal: true

Fabricator(:stanza) do
  number 1
  canto  { Fabricate(:canto) }
end
