# frozen_string_literal: true

class LinesController < ApplicationController
  # TODO: Split lines controller into learn and review controllers.
  # TODO: The learn controller should find the next unseen line for read/test.
  # TODO: The review controller should find the next line in need of review for read/test.
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
