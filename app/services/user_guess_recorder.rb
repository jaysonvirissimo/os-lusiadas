# frozen_string_literal: true

class UserGuessRecorder
  def initialize(guess:, user:, word:)
    @guess = guess
    @user = user
    @word = word
  end

  def call
    add_word_to_user
    record_outcome
    { correct: correct, word_value: word.value }
  end

  attr_reader :guess, :user, :word

  def add_word_to_user
    unless user.words.include?(word)
      user.words << word
    end
  end

  def correct
    @correct ||= word.match(guess)
  end

  def record_outcome
    if correct
      user.right_answer_for!(word)
    else
      user.wrong_answer_for!(word)
    end
  end
end
