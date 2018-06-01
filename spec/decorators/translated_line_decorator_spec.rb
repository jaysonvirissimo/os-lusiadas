# frozen_string_literal: true

require 'rails_helper'

describe TranslatedLineDecorator do
  let(:instance) { described_class.new(line) }
  let(:line) { Fabricate(:line, in_english: 'This line has been translated.') }

  it { expect(instance).to respond_to(:present) }
  it { expect(instance).to respond_to(:words) }

  describe '#classes' do
    it { expect(instance.classes).to match(/line/) }
    it { expect(instance.classes).to match(/is-italic/) }
  end
end
