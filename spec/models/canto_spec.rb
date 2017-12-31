require 'rails_helper'

RSpec.describe Canto, type: :model do
  let(:blank_instance) { described_class.new }

  context 'with an attribute-less instance' do
    it { expect(blank_instance).to_not be_valid }
  end

  describe '#stanzas' do
    it { expect(blank_instance.stanzas).to be_empty }
  end
end
