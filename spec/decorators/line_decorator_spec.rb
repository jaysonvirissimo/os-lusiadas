# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineDecorator do
  it { expect(described_class).to respond_to(:new) }

  context 'without specifying a step' do
    let(:canto) { Fabricate(:canto) }
    let(:stanza) { Fabricate(:stanza, canto: canto, number: 1) }
    let(:line) { Fabricate(:line, stanza: stanza, words: [word]) }
    let(:word) { Fabricate(:word, value: 'Peixe', position: 1) }

    subject { described_class.new(line) }

    describe 'seperates the first letter of the word from the rest' do
      let(:first_word) { subject.words.first }

      it { expect(first_word).to respond_to(:first) }
      it { expect(first_word).to respond_to(:rest) }
      it { expect(first_word).to respond_to(:position) }
      it { expect(first_word.first.value).to match(/P/) }
      it { expect(first_word.rest.value).to match(/eixe/) }
      it { expect(first_word.position).to eq(word.position) }
    end
  end

  describe LineDecorator::WordDecorator do
    let(:first_word) { Fabricate(:word, value: 'Um', position: 1) }
    let(:second_word) { Fabricate(:word, value: 'Dois', position: 2) }
    let(:instance) { described_class.new(word: word) }

    xit 'should display all the letters' do
    end
  end
end
