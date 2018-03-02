# frozen_string_literal: true

module WordsHelper
  def review_word_html(word)
    ReviewWordPresenter.new(word).html
  end

  def test_word_html(word)
    TestWordHTML.new(word).html
  end

  class TestWordHTML
    include ActionView::Helpers

    def initialize(word)
      @word = word
    end

    def html
      text_field_tag(class: word.classes, data: { word_id: word.id })
    end

    private

    attr_reader :word

    def style


    end
  end
end
