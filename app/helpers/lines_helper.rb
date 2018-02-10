module LinesHelper
  def element_for(word)
    content_tag(
      :span,
      content_tag(:span, word.first.value).concat(content_tag(:span, word.rest.value)),
      class: 'word'
    )
  end
end
