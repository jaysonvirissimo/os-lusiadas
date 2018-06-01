# frozen_string_literal: true

class TranslatedLineDecorator
  def initialize(line)
    @line = line
  end

  def classes
    'line is-italic'
  end

  def present
    LinePresenter.new(self)
  end

  def words
    @words ||= line.in_english.split(' ').map do |fragment|
      WordDecorator.new(fragment)
    end
  end

  private

  attr_reader :line

  class WordDecorator
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def present_html
      WordPresenter.new(self).html
    end
  end
end
