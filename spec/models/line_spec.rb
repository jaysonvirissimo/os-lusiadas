# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Line, type: :model do
  context 'with an attribute-less instance' do
    it { expect(described_class.new).to_not be_valid }
  end

  describe '.with_english_translations' do
    subject { described_class.with_english_translations }
    let(:with) do
      Fabricate(:line, in_english: 'Oi mate, you have a license for that?')
    end
    let(:null) { Fabricate(:line, in_english: nil) }
    let(:empty) { Fabricate(:line, in_english: '') }

    it 'includes those with an English translation' do
      expect(subject).to include(with)
    end
    it 'excludes those without an English translation' do
      expect(subject).to_not include(null, empty)
    end
  end

  describe '#destroy' do
    let(:line) { Fabricate(:line, words: [word]) }
    let(:word) { Fabricate(:word) }

    it 'also destroys the associated words' do
      expect(line).to be_persisted
      expect(word).to be_persisted
      line.destroy
      expect(line).to_not be_persisted
      expect(word).to_not be_persisted
    end
  end

  describe '#to_s' do
    let(:line) { Fabricate(:line, words: [first, second]) }
    let(:first) { Fabricate(:word, value: 'The', position: 1) }
    let(:second) { Fabricate(:word, value: 'end.', position: 2) }

    it 'displays the line properly formatted' do
      expect(line.to_s).to match(/The end./)
    end
  end

  describe '#to_ssml' do
    let(:line) { Fabricate(:line, words: words) }
    let(:words) do
      ["As", "armas", "e", "os", "barões", "assinalados,"].map.with_index do |word, index|
        Fabricate(:word, value: word, position: index + 1)
      end
    end

    specify do
      expect(line.to_ssml).to match("<s>As armas e os barões assinalados,</s>")
    end
  end

  describe '#words' do
    it { expect(described_class.new.words).to be_empty }
  end

  describe '#next_line' do
    context 'with more lines on the current stanza' do
      let!(:stanza) { Fabricate(:stanza, number: 1) }
      let!(:line) do
        Fabricate(:line, number: 1, absolute_number: 1, stanza: stanza)
      end
      let!(:next_line) do
        Fabricate(:line, number: 2, absolute_number: 2, stanza: stanza)
      end

      it 'returns the next line' do
        expect(line.next_line).to eq(next_line)
      end
    end

    context 'for the last line on the current stanza' do
      let!(:stanza) { Fabricate(:stanza, number: 1) }
      let!(:next_stanza) { Fabricate(:stanza, number: 2) }
      let!(:line) do
        Fabricate(:line, number: 8, absolute_number: 8, stanza: stanza)
      end
      let!(:next_line) do
        Fabricate(:line, number: 1, absolute_number: 9, stanza: next_stanza)
      end

      it 'returns the next line' do
        expect(line.next_line).to eq(next_line)
      end
    end
  end
end
