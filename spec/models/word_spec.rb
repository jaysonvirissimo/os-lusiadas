# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Word, type: :model do
  describe '#match' do
    let(:word) { Fabricate(:word, value: 'vós,') }
    subject { word.match(guess) }

    context 'with a bad guess' do
      let(:guess) { 'nope' }

      it { expect(subject).to be(false) }
    end

    context 'with a good, but incorrect guess' do
      let(:guess) { 'nos' }

      it { expect(subject).to be(false) }
    end

    context 'with an exact match' do
      let(:guess) { 'vós,' }

      it { expect(subject).to be(true) }
    end

    context 'with divergent capitalization' do
      let(:guess) { 'Vós,' }

      it { expect(subject).to be(true) }
    end

    context 'with differing punctuation' do
      let(:guess) { 'vós' }

      it { expect(subject).to be(true) }
    end

    context 'using only English letters' do
      let(:guess) { 'vos,' }

      it { expect(subject).to be(true) }
    end
  end
end
