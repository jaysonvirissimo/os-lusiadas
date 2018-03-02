# frozen_string_literal: true

module WordsHelper
  def review_word_html(word)
    ReviewWordHTML.new(word).html
  end

  def test_word_html(word)
    TestWordHTML.new(word).html
  end

  class ReviewWordHTML
    include ActionView::Helpers
    MAKE_WORD_VISIBLE = 'makeVisible(this);'
    VISIBILITY = { true => 'opacity: 1.0;', false => 'opacity: 0.0;' }.freeze

    def initialize(word)
      @first = word.first
      @rest = word.rest
    end

    def html
      content_tag(
        :span,
        inner_html,
        class: classes,
        onclick: MAKE_WORD_VISIBLE
      )
    end

    private

    attr_reader :first, :rest

    def classes
      if interesting?
        'tag is-light is-medium word'
      else
        'word'
      end
    end

    def inner_html
      first_html.concat(rest_html)
    end

    def interesting?
      return true unless first.visible
      return false if rest.value.blank?
      !rest.visible
    end

    def first_html
      content_tag(:span, first.value, style: VISIBILITY[first.visible])
    end

    def rest_html
      content_tag(:span, rest.value, style: VISIBILITY[rest.visible])
    end
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
