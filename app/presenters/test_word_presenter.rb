# frozen_string_literal: true

class TestWordPresenter
  include ActionView::Helpers

  def initialize(word)
    @word = word
  end

  def html
    content_tag(
      :div,
      control,
      class: 'field is-horizontal test-word'
    )
  end

  private

  attr_reader :word

  def control
    content_tag(:div, input, class: 'control', style: 'display: inline-block;')
  end

  def data
    { word_id: word.id }
  end

  def id
    "word-#{word.id}"
  end

  def input
    text_field_tag(id, nil, size: size, class: classes, data: data)
  end

  def size
    word.value.length
  end

  def classes
    [word.classes, 'input'].join(' ')
  end
end
