# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stanza, type: :model do
  let(:blank_instance) { described_class.new }

  context 'with an attribute-less instance' do
    it { expect(blank_instance).to_not be_valid }
  end

  describe '#canto' do
    let(:instance) { Fabricate(:stanza) }

    it { expect(instance.canto).to be }
  end

  describe '#destroy' do
    let(:line) { Fabricate(:line) }
    let(:stanza) { Fabricate(:stanza, lines: [line]) }

    it 'also destroys the associated lines' do
      expect(stanza).to be_persisted
      expect(line).to be_persisted
      stanza.destroy
      expect(stanza).to_not be_persisted
      expect(line).to_not be_persisted
    end
  end
end
