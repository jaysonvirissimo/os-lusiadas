# frozen_string_literal: true

class WordsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:score]

  def score
    if word.present?
      render json: outcome
    else
      head :not_found
    end
  end

  private

  def guess
    params[:guess]
  end

  def outcome
    UserGuessRecorder.new(guess: guess, user: user, word: word).call
  end

  def user
    return current_user if current_user.present?
    NullUser.new
  end

  def word
    @word ||= Word.find_by(id: params[:word_id])
  end
end
