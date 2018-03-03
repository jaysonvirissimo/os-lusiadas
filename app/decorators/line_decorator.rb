# frozen_string_literal: true

class LineDecorator
  attr_reader :line

  def initialize(line)
    @line = line
  end

  def classes
    'line'
  end

  def words
    @words ||= line.words.order(:position).map do |word|
      WordDecorator.new(word: word)
    end
  end

  private

  class WordDecorator
    attr_reader :id, :position

    def initialize(word:)
      @characters = word.value.chars
      @id = word.id
      @position = word.position
    end

    def present
      ReviewWordPresenter.new(self).html
    end

    def classes
      'word'
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
