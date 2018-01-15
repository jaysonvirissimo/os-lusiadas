# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Line, type: :model do
  context 'with an attribute-less instance' do
    it { expect(described_class.new).to_not be_valid }
  end

  describe '#words' do
    it { expect(described_class.new.words).to be_empty }
  end
end
