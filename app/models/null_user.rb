# frozen_string_literal: true

class NullUser
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
