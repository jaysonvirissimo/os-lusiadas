# frozen_string_literal: true

Fabricator(:word) do
  line     { Fabricate(:line) }
  value    'Word'
  position 1
end
