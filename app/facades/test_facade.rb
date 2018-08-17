# frozen_string_literal: true

class TestFacade < PoemFacade
  def initialize(line:, with_translations: false)
    super(line)
    @with_translations = with_translations
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

  private

  def decorators_for(this_line)
    [
      translated_line_decorator_for(this_line),
      line_decorator_for(this_line)
    ].compact
  end

  def line_decorator_for(this_line)
    if this_line == line
      TestLineDecorator.new(this_line)
    else
      LineDecorator.new(this_line)
    end
  end

  def lines
    @lines ||= stanza.lines.order(:number).map do |current_line|
      decorators_for(current_line)
    end.flatten
  end

  def translated_line_decorator_for(this_line)
    return unless with_translations? && this_line.in_english?
    TranslatedLineDecorator.new(this_line)
  end

  def with_translations?
    @with_translations
  end
end
