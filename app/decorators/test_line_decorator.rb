# frozen_string_literal: true

class TestLineDecorator
  def initialize(line)
    @line = line
  end

  def classes
    'line'
  end

  def words
    @words ||= line.words.order(:position).map do |word|
      WordDecorator.new(word)
    end
  end

  private

  attr_reader :line

  class WordDecorator < SimpleDelegator
    def classes
      'word'
    end

    def present_html
      TestWordPresenter.new(self).html
    end
  end
end
