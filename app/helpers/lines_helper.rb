# frozen_string_literal: true

module LinesHelper
  def element_for(word)
    content_tag(
      :span,
      content_tag(:span, word.first.value, style: style(word.first.visible)).concat(content_tag(:span, word.rest.value, style: style(word.rest.visible))),
      class: 'word'
    )
  end

  def style(visible)
    if visible
      'visibility: visible;'
    else
      'visibility: hidden;'
    end
  end
end
