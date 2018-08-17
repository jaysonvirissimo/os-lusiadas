# frozen_string_literal: true

class PoemFacade
  POEM_NAME = 'Os Lusiadas'

  attr_reader :line

  def initialize(line)
    @line = line
  end

  def canto_name
    canto.name
  end

  def present_lines
    lines.map do |line_to_present|
      line_to_present.present.html
    end.join.html_safe
  end

  def poem_name
    POEM_NAME
  end

  def stanza_number
    "Stanza #{stanza.number}"
  end

  protected

  def canto
    stanza.canto
  end

  def stanza
    line.stanza
  end
end
