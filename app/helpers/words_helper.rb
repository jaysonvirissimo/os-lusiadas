# frozen_string_literal: true

module WordsHelper
  def test_word_html(word)
    TestWordPresenter.new(word).html
  end
end
