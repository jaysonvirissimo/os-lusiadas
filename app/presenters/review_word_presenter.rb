class ReviewWordPresenter
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
