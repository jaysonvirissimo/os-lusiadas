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
    @words ||= line.words.order(:position).map do |word|
      WordPresenter.new(word: word, step: step)
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

  class WordPresenter
    attr_reader :position, :visible

    def initialize(word:, step:)
      @characters = word.value.chars
      @position = word.position
      @visible = visible
    end

    def first
      @first ||= OpenStruct.new(
        value: characters.take(1).join,
        visible: visible
      )
    end

    def rest
      @rest ||= OpenStruct.new(value: characters.drop(1).join, visible: visible)
    end

    private

    attr_reader :characters
  end
end
