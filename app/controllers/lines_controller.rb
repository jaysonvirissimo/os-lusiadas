# frozen_string_literal: true

class LinesController < ApplicationController
  # TODO: Extract nav bar logic into PORO.
  # OPTIMIZE: Improve read action performance.
  # Consider eager loading words along with lines.
  def read
    @read_facade = ReadFacade.new(line: line, step: step.to_i)
  end

  def test
    @test_facade = TestFacade.new(line)
  end

  private

  def line
    @line ||= Line.find_by(id: params[:id]) || Line.first
  end

  def step
    params[:step] || 0
  end
end
