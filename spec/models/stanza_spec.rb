# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stanza, type: :model do
  let(:blank_instance) { described_class.new }

  context 'with an attribute-less instance' do
    it { expect(blank_instance).to_not be_valid }
  end

  context '#canto' do
    let(:instance) { Fabricate(:stanza) }

    it { expect(instance.canto).to be }
  end
end
