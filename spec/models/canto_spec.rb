# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Canto, type: :model do
  let(:blank_instance) { described_class.new }

  context 'with an attribute-less instance' do
    it { expect(blank_instance).to_not be_valid }
  end

  describe '#destroy' do
    let(:stanza) { Fabricate(:stanza) }
    let(:canto) { Fabricate(:canto, stanzas: [stanza]) }

    it 'also destroys the associated stanzas' do
      expect(canto).to be_persisted
      expect(stanza).to be_persisted
      canto.destroy
      expect(canto).to_not be_persisted
      expect(stanza).to_not be_persisted
    end
  end

  describe '#stanzas' do
    it { expect(blank_instance.stanzas).to be_empty }
  end
end
