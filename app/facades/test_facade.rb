# frozen_string_literal: true

class TestFacade
  POEM_NAME = 'Os Lusiadas'
  attr_reader :line

  def initialize(line:, with_translations: false)
    @line = line
    @with_translations = with_translations
  end

  def canto_name
    canto.name
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
    @retry_button ||= OpenStruct.new(
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

  def present_lines
    lines.map do |line_to_present|
      line_to_present.present.html
    end.join.html_safe
  end

  private

  def canto
    stanza.canto
  end

  def decorators_for(this_line)
    [].tap do |array|
      if with_translations? && this_line.in_english?
        array << TranslatedLineDecorator.new(this_line)
      end

      if this_line == line
        array << TestLineDecorator.new(this_line)
      else
        array << LineDecorator.new(this_line)
      end
    end
  end

  def lines
    @lines ||= stanza.lines.order(:number).map do |current_line|
      decorators_for(current_line)
    end.flatten
  end

  def stanza
    line.stanza
  end

  def with_translations?
    @with_translations
  end
end
