# frozen_string_literal: true

class LinePresenter
  attr_reader :line

  def initialize(line:)
    @line = line
  end

  def words
    @words ||= line.words.order(:position).map do |word|
      WordPresenter.new(word: word)
    end
  end

  private

  class WordPresenter
    attr_reader :position

    def initialize(word:)
      @characters = word.value.chars
      @position = word.position
    end

    def first
      @first ||= OpenStruct.new(value: characters.take(1).join, visible: true)
    end

    def rest
      @rest ||= OpenStruct.new(value: characters.drop(1).join, visible: true)
    end

    private

    attr_reader :characters
  end
end
