# frozen_string_literal: true

module WordsHelper
  def review_word_html(word)
    ReviewWordPresenter.new(word).html
  end

  def test_word_html(word)
    TestWordPresenter.new(word).html
  end
end
