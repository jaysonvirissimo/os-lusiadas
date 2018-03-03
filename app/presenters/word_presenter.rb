# frozen_string_literal: true

class WordPresenter
  include ActionView::Helpers

  def initialize(word)
    @word = word
  end

  def html
    content_tag(:span, word.value, class: classes)
  end

  private

  attr_reader :word

  def classes
    'word'
  end
end
