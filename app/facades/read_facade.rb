# frozen_string_literal: true

class ReadFacade
  POEM_NAME = 'Os Lusiadas'
  VALID_STEPS = (0..5)

  attr_reader :line, :step

  def initialize(line:, step: 0)
    @line = line
    @step = step
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

  def poem_name
    POEM_NAME
  end

  def canto_name
    canto.name
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
      array << TranslatedLineDecorator.new(this_line) if this_line.in_english?

      if this_line == line
        array << ReviewLineDecorator.new(line: this_line, step: step)
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

  def next_line
    @next_line ||= line.next_line
  end

  def stanza
    line.stanza
  end
end
