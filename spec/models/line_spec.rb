# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Line, type: :model do
  context 'with an attribute-less instance' do
    it { expect(described_class.new).to_not be_valid }
  end

  describe '#words' do
    it { expect(described_class.new.words).to be_empty }
  end

  describe '#next_line' do
    context 'with more lines on the current stanza' do
      let!(:stanza) { Fabricate(:stanza, number: 1) }
      let!(:line) { Fabricate(:line, number: 1, stanza: stanza) }
      let!(:next_line) { Fabricate(:line, number: 2, stanza: stanza) }

      it 'returns the next line' do
        expect(line.next_line).to eq(next_line)
      end
    end

    context 'for the last line on the current stanza' do
      let!(:stanza) { Fabricate(:stanza, number: 1) }
      let!(:next_stanza) { Fabricate(:stanza, number: 2) }
      let!(:line) { Fabricate(:line, number: 1, stanza: stanza) }
      let!(:next_line) { Fabricate(:line, number: 1, stanza: next_stanza) }

      it 'returns the next line' do
        expect(line.next_line).to eq(next_line)
      end
    end
  end
end
