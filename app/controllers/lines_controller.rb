# frozen_string_literal: true

class LinesController < ApplicationController
  def review
    @review_facade = ReviewFacade.new(line: line, step: step.to_i)
  end

  def test
    @test_facade = TestFacade.new(line)
  end

  private

  def line
    @line ||= Line.find_by(number: params[:number] || 1)
  end

  def step
    params[:step] || 0
  end
end
