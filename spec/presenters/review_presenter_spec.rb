# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewPresenter do
  it { expect(described_class).to respond_to(:new) }

  context 'without specifying a step' do
    let(:canto) { Fabricate(:canto) }
    let(:stanza) { Fabricate(:stanza, canto: canto, number: 1) }
    let(:line) { Fabricate(:line, stanza: stanza, number: 1, words: [word]) }
    let(:word) { Fabricate(:word, value: 'Peixe', position: 1) }

    subject { described_class.new(line: line) }

    it { expect(subject).to respond_to(:step) }
    it { expect(subject).to respond_to(:back_button) }
    it { expect(subject).to respond_to(:next_button) }
    it { expect(subject.step).to be_zero }
    it { expect(subject.poem_name).to match(/Os Lusiadas/) }
    it { expect(subject.canto_name).to eq(canto.name) }
    it { expect(subject.stanza_number).to match(/Stanza 1/) }

    describe '#lines' do
      let!(:other_line) { Fabricate(:line, stanza: stanza, number: 2) }

      it 'presents the review line' do
        expect(subject.lines.first).to be_a(ReviewLinePresenter)
      end
      it 'presents the non-review lines' do
        expect(subject.lines.last).to be_a(LinePresenter)
      end
    end
  end
end
