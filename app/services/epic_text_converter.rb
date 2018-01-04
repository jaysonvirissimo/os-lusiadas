# frozen_string_literal: true

class EpicTextConverter
  PORTUGUESE_ORDINALS = %w[
    Primeiro
    Segundo
    Terceiro
    Quarto
    Quinto
    Sexto
    Sétimo
    Oitavo
    Nono
    Décimo
  ].freeze

  def self.convert(string)
    new(string).convert
  end

  def initialize(string)
    @string = string
  end

  def convert; end
end
