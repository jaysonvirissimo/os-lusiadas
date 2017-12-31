require 'rails_helper'

RSpec.describe Canto, type: :model do
  context 'with an attribute-less instance' do
    let(:instance) { Canto.new }

    it { expect(instance).to_not be_valid }
  end
end
