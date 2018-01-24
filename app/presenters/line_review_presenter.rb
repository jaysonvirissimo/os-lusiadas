# frozen_string_literal: true

class LineReviewPresenter
  POEM_NAME = 'Os Lusiadas'

  attr_reader :step

  def initialize(line:, step: 0)
    @line = line
    @step = step
  end

  def canto_name
    @canto_name ||= stanza.canto.display_name
  end

  def poem_name
    POEM_NAME
  end

  def stanza_number
    @stanza_number ||= "Stanza #{stanza.number}"
  end

  def words
    @words = line.words.order(:position).map do |word|
      present_word(word.value.chars, word.position)
    end
  end

  private

  attr_reader :line

  def canto
    stanza.canto
  end

  def stanza
    line.stanza
  end

  def present_word(characters, position)
    OpenStruct.new(
      first: characters.take(1).join,
      rest: characters.drop(1).join,
      position: position
    )
  end
end
