# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestFacade do
  let(:canto) { Fabricate(:canto) }
  let(:stanza) { Fabricate(:stanza, canto: canto, number: 1) }
  let(:line) { Fabricate(:line, stanza: stanza, number: 1, words: [word]) }
  let(:word) { Fabricate(:word, value: 'Peixe', position: 1) }
  subject { described_class.new(line) }

  it { expect(described_class).to respond_to(:new) }

  describe '#lines' do
    let!(:other_line) { Fabricate(:line, stanza: stanza, number: 2) }

    it 'presents the test line' do
      expect(subject.lines.first).to be_a(TestLinePresenter)
    end
    it 'presents the non-test lines' do
      expect(subject.lines.last).to be_a(LineDecorator)
    end
  end
end
