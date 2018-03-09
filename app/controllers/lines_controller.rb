# frozen_string_literal: true

class LinesController < ApplicationController
  # TODO: Create learn action for practicing unseen words.
  # TODO: Update review action to find word (line) in most new of review.
  def review
    @review_facade = ReviewFacade.new(line: line, step: step.to_i)
  end

  # TODO: Update test to record user's word repetition history.
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
