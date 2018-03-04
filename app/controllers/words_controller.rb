# frozen_string_literal: true

class WordsController < ApplicationController
  def score
    if word.present?
      render json: { correct: correct?, word_value: word.value }
    else
      head :not_found
    end
  end

  private

  def correct?
    word.match(params[:guess])
  end

  def word
    @word ||= Word.find_by(id: params[:word_id])
  end
end
