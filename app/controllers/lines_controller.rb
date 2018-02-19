# frozen_string_literal: true

class LinesController < ApplicationController
  def review
    @review_presenter = ReviewPresenter.new(line: line)
  end

  def test; end

  private

  def line
    @line ||= Line.find(params[:id] || 1)
  end
end
