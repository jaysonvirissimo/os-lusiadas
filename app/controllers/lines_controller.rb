# frozen_string_literal: true

class LinesController < ApplicationController
  # TODO: Extract footer to read facade.
  # OPTIMIZE: Improve read action performance.
  # Consider eager loading words along with lines.
  def read
    @read_facade = read_facade
  end

  # TODO: Extract footer to test facade.
  def test
    @test_facade = test_facade
  end

  private

  def line
    @line ||= Line.find_by(id: params[:id]) || Line.first
  end

  def read_facade
    ReadFacade.new(
      line: line,
      step: step.to_i,
      with_translations: viewing_user.read_translation
    )
  end

  def step
    params[:step] || 0
  end

  def test_facade
    TestFacade.new(line: line, with_translations: viewing_user.test_translation)
  end
end
