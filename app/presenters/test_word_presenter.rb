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
    content_tag(:div, input, class: 'control', style: control_style)
  end

  def data
    { word_id: word.id }
  end

  def id
    word.id.to_s
  end

  def input
    text_field_tag(
      id,
      nil,
      size: size,
      class: input_classes,
      data: data,
      disabled: word.disabled
    )
  end

  def size
    word.value.length
  end

  def control_style
    'display: inline-block;'
  end

  def input_classes
    [word.classes, 'input'].join(' ')
  end
end
