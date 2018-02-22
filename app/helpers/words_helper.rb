# frozen_string_literal: true

module WordsHelper
  def review_word_html(word)
    ReviewWordHTML.new(word).html
  end

  class ReviewWordHTML
    include ActionView::Helpers
    MAKE_WORD_VISIBLE = %{
      Array.prototype.forEach.call(this.children, function(el, i) {
        el.style.opacity = 1.0;
      });
    }.delete(' ').freeze
    VISIBILITY = { true => 'opacity: 1.0;', false => 'opacity: 0.0;' }.freeze

    def initialize(word)
      @first = word.first
      @rest = word.rest
    end

    def html
      content_tag(:span, inner_html, class: 'word', onclick: MAKE_WORD_VISIBLE)
    end

    private

    attr_reader :first, :rest

    def inner_html
      first_html.concat(rest_html)
    end

    def first_html
      content_tag(:span, first.value, style: VISIBILITY[first.visible])
    end

    def rest_html
      content_tag(:span, rest.value, style: VISIBILITY[rest.visible])
    end
  end
end
