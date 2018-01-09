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
  STANZA_BOUNDS = (1..156)

  def self.convert(string)
    new(string).convert
  end

  def initialize(string)
    @string = string
  end

  def convert
    build_cantos
    build_stanzas
  end

  private

  attr_accessor :current_canto, :current_stanza
  attr_reader :cantos, :current_canto, :string

  def build_cantos
    PORTUGUESE_ORDINALS.each_with_index do |ordinal, index|
      Canto.create(name: "Canto #{ordinal}", number: index + 1)
    end

    @cantos = Canto.order(:number)
  end

  def build_stanzas
    string.each_line do |line|
      next if line.blank?
      convert_line(line)
    end
  end

  def convert_line(line)
    if STANZA_BOUNDS.include?(line.strip.to_i)
      self.current_stanza = Stanza.create(number: line.strip.to_i, canto: current_canto)
    elsif cantos.pluck(:name).include?(line.strip)
      self.current_canto = cantos.find_by(name: line.strip)
    end
  end
end
