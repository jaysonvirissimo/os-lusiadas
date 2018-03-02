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

  def poem_name
    POEM_NAME
  end

  def stanza_number
    stanza.number
  end

  private

  def stanza
    line.stanza
  end

  def canto
    stanza.canto
  end
end
