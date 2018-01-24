# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineReviewPresenter do
  it { expect(described_class).to respond_to(:new)}

  context 'without specifying a step' do
    let(:canto) { Fabricate(:canto) }
    let(:stanza) { Fabricate(:stanza, canto: canto, number: 1) }
    let(:line) { Fabricate(:line, stanza: stanza, words: [word]) }
    let(:word) { Fabricate(:word, value: 'Peixe', position: 1) }

    subject { described_class.new(line: line) }

    it { expect(subject).to respond_to(:step) }
    it { expect(subject.step).to be_zero }
    it { expect(subject.poem_name).to match(/Os Lusiadas/) }
    it { expect(subject.canto_name).to eq(canto.display_name) }
    it { expect(subject.stanza_number).to match(/Stanza 1/) }

    describe 'seperates the first letter of the word from the rest' do
      let(:first_word) { subject.words.first }

      it { expect(first_word).to respond_to(:first) }
      it { expect(first_word).to respond_to(:rest) }
      it { expect(first_word).to respond_to(:position) }
      it { expect(first_word.first).to match(/P/) }
      it { expect(first_word.rest).to match(/eixe/) }
      it { expect(first_word.position).to eq(word.position)}
    end
  end
end
