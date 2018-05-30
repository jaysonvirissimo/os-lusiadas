# frozen_string_literal: true

class LinePresenter
  include ActionView::Helpers

  def initialize(line)
    @line = line
  end

  def html
    content_tag(:li, inner_html, class: line.classes)
  end

  private

  attr_reader :line

  def inner_html
    line.words.map(&:present_html).join(' ').html_safe
  end
end
