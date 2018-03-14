# frozen_string_literal: true

require 'rails_helper'

describe UserGuessRecorder do
  let(:user) { Fabricate(:user) }
  let(:word) { Fabricate(:word, value: 'gato') }
  let(:instance) { described_class.new(guess: guess, user: user, word: word) }

  context 'with a correct guess' do
    let(:guess) { 'gato' }

    describe 'returns the appropriate hash' do
      let(:outcome) { instance.call }

      it { expect(outcome[:correct]).to be(true) }
      it { expect(outcome[:word_value]).to eq(word.value) }
    end

    it 'updates the user record' do
      expect(user.words.known).to_not include(word)
      instance.call
      expect(user.words.known).to include(word)
    end
  end

  context 'with an incorrect guess' do
    let(:guess) { 'gate' }

    describe 'returns the appropriate hash' do
      let(:outcome) { instance.call }

      it { expect(outcome[:correct]).to be(false) }
      it { expect(outcome[:word_value]).to eq(word.value) }
    end

    it 'updates the user record' do
      expect(user.words.known).to_not include(word)
      instance.call
      expect(user.words.known).to_not include(word)
    end
  end
end
