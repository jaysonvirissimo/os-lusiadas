# frozen_string_literal: true

class NullUser
  def next_line_to_learn
    Line.find_by(absolute_number: 1)
  end

  def right_answer_for!(word)
    word
  end

  def words
    []
  end

  def wrong_answer_for!(word)
    word
  end
end
