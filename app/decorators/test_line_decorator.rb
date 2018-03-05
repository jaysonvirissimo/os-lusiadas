# frozen_string_literal: true

class TestLineDecorator
  def initialize(line)
    @line = line
  end

  def classes
    'line'
  end

  def words
    @words ||= line.words.order(:position).map.with_index do |word, index|
      WordDecorator.new(word: word, disabled: index.positive?)
    end
  end

  private

  attr_reader :line

  class WordDecorator < SimpleDelegator
    attr_reader :disabled

    def initialize(word:, disabled:)
      @disabled = disabled
      super(word)
    end

    def classes
      'word'
    end

    def present_html
      TestWordPresenter.new(self).html
    end
  end
end
