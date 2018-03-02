class TestWordPresenter
    include ActionView::Helpers

    def initialize(word)
      @word = word
    end

    def html
      text_field_tag(class: word.classes, data: { word_id: word.id })
    end

    private

    attr_reader :word
  end
