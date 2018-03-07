# frozen_string_literal: true

class TestFacade
  POEM_NAME = 'Os Lusiadas'
  attr_reader :line

  def initialize(line)
    @line = line
  end

  def canto_name
    canto.name
  end

  def lines
    @lines ||= stanza.lines.order(:number).map do |current_line|
      if current_line == line
        TestLineDecorator.new(current_line)
      else
        LineDecorator.new(current_line)
      end
    end
  end

  def next_button
    @next_button ||= OpenStruct.new(
      classes: 'card-footer-item',
      condition?: true,
      id: 'next-button',
      name: 'Review Next',
      options: { id: line.next_line.id, step: 0 }
    )
  end

  def retry_button
    @reset_button ||= OpenStruct.new(
      classes: 'card-footer-item',
      condition?: true,
      id: 'retry-button',
      name: 'Retry Test',
      options: { id: line.id }
    )
  end

  def poem_name
    POEM_NAME
  end

  def stanza_number
    "Stanza #{stanza.number}"
  end

  private

  def stanza
    line.stanza
  end

  def canto
    stanza.canto
  end
end
