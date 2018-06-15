# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NullUser do
  let(:instance) { NullUser.new }

  describe '#next_line_to_learn' do
    let!(:line) { Fabricate(:line, absolute_number: 1) }

    it 'always returns the first line of the poem' do
      expect(instance.next_line_to_learn).to eq(line)
    end
  end

  describe '#next_line_to_review' do
    it { expect(instance.next_line_to_review).to_not be }
  end

  describe '#read_translation' do
    it 'defaults to true' do
      expect(instance.read_translation).to be_truthy
    end
  end

  describe '#review_count' do
    it { expect(instance.review_count).to be_zero }
  end

  describe '#right_answer_for!' do
    let(:word) { Fabricate(:word) }

    it { expect(instance.right_answer_for!(word)).to be_truthy }
  end

  describe '#test_translation' do
    it 'defaults to false' do
      expect(instance.test_translation).to be_falsey
    end
  end

  describe '#words' do
    it { expect(instance.words).to be_empty }
  end

  describe '#wrong_answer_for!' do
    let(:word) { Fabricate(:word) }

    it { expect(instance.wrong_answer_for!(word)).to be_truthy }
  end
end
