# frozen_string_literal: true

class ReviewPresenter
  POEM_NAME = 'Os Lusiadas'

  attr_reader :line, :step

  def initialize(line:, step: 0)
    @line = line
    @step = step
    raise unless (0..5).cover?(step)
  end

  def poem_name
    POEM_NAME
  end

  def canto_name
    canto.name
  end

  def stanza_number
    "Stanza #{stanza.number}"
  end

  def lines
    @lines ||= stanza.lines.order(:number).map do |current_line|
      if current_line == line
        ReviewLinePresenter.new(line: current_line, step: step)
      else
        LinePresenter.new(line: current_line)
      end
    end
  end

  private

  def stanza
    line.stanza
  end

  def canto
    stanza.canto
  end
end
