# frozen_string_literal: true

class LineReviewPresenter
  POEM_NAME = 'Os Lusiadas'

  attr_reader :line, :step

  def initialize(line:, step: 0)
    @line = line
    @step = step
    raise unless (0..5).cover?(step)
  end

  def canto_name
    @canto_name ||= stanza.canto.name
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

  def canto
    stanza.canto
  end

  def stanza
    line.stanza
  end

  class WordPresenter
    attr_reader :position

    def initialize(word:, step:)
      @characters = word.value.chars
      @position = word.position
      @step = step
    end

    def first
      @first ||= OpenStruct.new(
        value: characters.take(1).join,
        visible: step.zero? || first_visible
      )
    end

    def rest
      @rest ||= OpenStruct.new(
        value: characters.drop(1).join,
        visible: step.zero? || rest_visible
      )
    end

    private

    attr_reader :characters, :step

    def first_visible
      if position.odd?
        [1, 2, 3].include?(step)
      else
        [1, 2, 3, 4].include?(step)
      end
    end

    def rest_visible
      step == (position.odd? ? 2 : 1)
    end
  end
end
