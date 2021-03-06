# frozen_string_literal: true

class ReadFacade < PoemFacade
  VALID_STEPS = (0..5)

  attr_reader :step

  def initialize(line:, step: 0, with_translations: true)
    super(line)
    @step = step
    @with_translations = with_translations
    raise unless VALID_STEPS.cover?(step)
  end

  def back_button
    @back_button ||= OpenStruct.new(
      condition?: step.positive?,
      name: 'Back',
      options: { id: line.id, step: step - 1 }
    )
  end

  def done_button
    @done_button ||= OpenStruct.new(
      condition?: step == VALID_STEPS.last && next_line,
      name: 'Done',
      options: { id: line.id }
    )
  end

  def next_button
    @next_button ||= OpenStruct.new(
      condition?: VALID_STEPS.cover?(step + 1),
      name: 'Next',
      id: 'next-iteration',
      options: { id: line.id, step: step + 1 }
    )
  end

  def reset_button
    @reset_button ||= OpenStruct.new(
      condition?: step != 0,
      name: 'Reset',
      options: { id: line.id, step: 0 }
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
      ReviewLineDecorator.new(line: this_line, step: step)
    else
      LineDecorator.new(this_line)
    end
  end

  def lines
    @lines ||= stanza.lines.order(:number).map do |current_line|
      decorators_for(current_line)
    end.flatten
  end

  def next_line
    @next_line ||= line.next_line
  end

  def translated_line_decorator_for(this_line)
    return unless with_translations? && this_line.in_english?
    TranslatedLineDecorator.new(this_line)
  end

  def with_translations?
    @with_translations
  end
end
