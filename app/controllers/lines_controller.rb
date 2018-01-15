class LinesController < ApplicationController
  def read
  end

  def recall
  end

  def test
  end

  private

  def line
    @line ||= Line.find(params[:id] || 1)
  end
end
