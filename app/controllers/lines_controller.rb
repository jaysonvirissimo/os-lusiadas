# frozen_string_literal: true

class LinesController < ApplicationController
  # TODO: Review nav button displays disabled for null users.
  # TODO: Review nav button displays review count.
  # TODO: Extract nav bar logic into PORO.
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
