# frozen_string_literal: true

class ReviewFacade
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
      options: { number: line.number }
    )
  end

  def next_button
    @next_button ||= OpenStruct.new(
      condition?: VALID_STEPS.cover?(step + 1),
      name: 'Next',
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

  def lines
    @lines ||= stanza.lines.order(:number).map do |current_line|
      if current_line == line
        ReviewLineDecorator.new(line: current_line, step: step)
      else
        LineDecorator.new(current_line)
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

  def next_line
    @next_line ||= line.next_line
  end
end
