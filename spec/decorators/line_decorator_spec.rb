# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineDecorator do
  let(:canto) { Fabricate(:canto) }
  let(:stanza) { Fabricate(:stanza, canto: canto, number: 1) }
  let(:line) { Fabricate(:line, stanza: stanza, words: [word]) }
  let(:word) { Fabricate(:word, value: 'Peixe', position: 1) }
  subject { described_class.new(line) }

  it { expect(described_class).to respond_to(:new) }
  it 'knows its own classes' do
    expect(subject.classes).to eq('line')
  end

  describe LineDecorator::WordDecorator do
    let(:instance) { described_class.new(word) }

    it 'should delegate to word model' do
      expect(instance.value).to eq(word.value)
      expect(instance.position).to eq(word.position)
    end
  end
end
