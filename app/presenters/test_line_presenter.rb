class TestLinePresenter
  def initialize(line)
    @line = line
  end

  def classes
    'line'
  end

  def words
    @words ||= line.words.order(:position).map do |word|
      WordPresenter.new(word)
    end
  end

  private

  attr_reader :line

  class WordPresenter
    def initialize(word)
      @word = word
    end

    def classes
      'word'
    end

    def id
      word.id
    end

    private

    attr_reader :word
  end
end
