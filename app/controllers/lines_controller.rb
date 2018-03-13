# frozen_string_literal: true

class LinesController < ApplicationController
  # TODO: Review nav button goes to next line to review and displays count.
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

  def user
    current_user || NullUser.new
  end

  helper_method :user
end
