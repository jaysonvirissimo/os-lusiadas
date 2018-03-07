# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewFacade do
  let(:canto) { Fabricate(:canto) }
  let(:stanza) { Fabricate(:stanza, canto: canto, number: 1) }
  let(:line) { Fabricate(:line, stanza: stanza, number: 1, words: [word]) }
  let(:word) { Fabricate(:word, value: 'Peixe', position: 1) }

  it { expect(described_class).to respond_to(:new) }

  context 'without specifying a step' do
    subject { described_class.new(line: line) }

    it { expect(subject).to respond_to(:step) }
    it { expect(subject).to respond_to(:back_button) }
    it { expect(subject).to respond_to(:next_button) }
    it { expect(subject.step).to be_zero }
    it { expect(subject.poem_name).to match(/Os Lusiadas/) }
    it { expect(subject.canto_name).to eq(canto.name) }
    it { expect(subject.stanza_number).to match(/Stanza 1/) }

    it 'does not have a back button' do
      expect(subject.back_button).to_not be_condition
    end

    it 'does not have a reset button' do
      expect(subject.reset_button).to_not be_condition
    end

    it 'does not have a done button' do
      expect(subject.done_button).to_not be_condition
    end

    describe '#lines' do
      let!(:other_line) { Fabricate(:line, stanza: stanza, number: 2) }

      it 'presents the review line' do
        expect(subject.lines.first).to be_a(ReviewLineDecorator)
      end
      it 'presents the non-review lines' do
        expect(subject.lines.last).to be_a(LineDecorator)
      end
    end
  end

  context 'on step 1' do
    subject { described_class.new(line: line, step: 1) }

    describe '#reset_button' do
      it { expect(subject.reset_button).to be_condition }
      it { expect(subject.reset_button.options[:id]).to eq(line.id) }
      it { expect(subject.reset_button.options[:step]).to be_zero }
    end

    describe '#back_button' do
      it { expect(subject.back_button).to be_condition }
      it { expect(subject.back_button.options[:id]).to eq(line.id) }
      it { expect(subject.back_button.options[:step]).to be_zero }
    end

    describe '#next_button' do
      it { expect(subject.next_button).to be_condition }
      it { expect(subject.next_button.options[:id]).to eq(line.id) }
      it { expect(subject.next_button.options[:step]).to eq(2) }
    end
  end

  context 'on step 5' do
    subject { described_class.new(line: line, step: 5) }

    describe '#reset_button' do
      it { expect(subject.reset_button).to be_condition }
      it { expect(subject.reset_button.options[:id]).to eq(line.id) }
      it { expect(subject.reset_button.options[:step]).to be_zero }
    end

    describe '#back_button' do
      it { expect(subject.back_button).to be_condition }
      it { expect(subject.back_button.options[:id]).to eq(line.id) }
      it { expect(subject.back_button.options[:step]).to eq(4) }
    end

    describe '#next_button' do
      it { expect(subject.next_button).to_not be_condition }
    end

    describe '#done_button' do
      let!(:next_stanza) { Fabricate(:stanza, canto: canto, number: 2) }
      let!(:next_line) { Fabricate(:line, number: number, stanza: next_stanza) }
      let(:number) { 1 }

      it { expect(subject.done_button).to be_condition }
      it { expect(subject.done_button.options).to have_key(:id) }
    end
  end
end
