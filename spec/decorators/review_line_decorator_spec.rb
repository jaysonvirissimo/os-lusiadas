# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewLineDecorator do
  it { expect(described_class).to respond_to(:new) }

  context 'without specifying a step' do
    let(:canto) { Fabricate(:canto) }
    let(:stanza) { Fabricate(:stanza, canto: canto, number: 1) }
    let(:line) { Fabricate(:line, stanza: stanza, words: [word]) }
    let(:word) { Fabricate(:word, value: 'Peixe', position: 1) }

    subject { described_class.new(line: line) }

    describe 'seperates the first letter of the word from the rest' do
      let(:first_word) { subject.words.first }

      it { expect(first_word).to respond_to(:display) }
      it { expect(first_word).to respond_to(:first) }
      it { expect(first_word).to respond_to(:rest) }
      it { expect(first_word).to respond_to(:position) }
      it { expect(first_word.first.value).to match(/P/) }
      it { expect(first_word.rest.value).to match(/eixe/) }
      it { expect(first_word.position).to eq(word.position) }
    end
  end

  describe ReviewLineDecorator::WordDecorator do
    let(:first_word) { Fabricate(:word, value: 'Um', position: 1) }
    let(:second_word) { Fabricate(:word, value: 'Dois', position: 2) }
    let(:instance) { described_class.new(word: word, step: step) }

    context 'on step zero' do
      let(:step) { 0 }

      context 'the first word' do
        let(:word) { first_word }

        it 'should display the all the letters' do
          expect(instance.first.visible).to be_truthy
          expect(instance.rest.visible).to be_truthy
        end
      end

      context 'the second word' do
        let(:word) { second_word }

        it 'should display all the letters' do
          expect(instance.first.visible).to be_truthy
          expect(instance.first.visible).to be_truthy
        end
      end
    end

    context 'on step one' do
      let(:step) { 1 }

      context 'the first word' do
        let(:word) { first_word }

        it 'should display only the first letter' do
          expect(instance.first.visible).to be_truthy
          expect(instance.rest.visible).to be_falsey
        end
      end

      context 'the second word' do
        let(:word) { second_word }

        it 'should display all the letters' do
          expect(instance.first.visible).to be_truthy
          expect(instance.first.visible).to be_truthy
        end
      end
    end

    context 'on step two' do
      let(:step) { 2 }

      context 'the first word' do
        let(:word) { first_word }

        it 'should display the all the letters' do
          expect(instance.first.visible).to be_truthy
          expect(instance.rest.visible).to be_truthy
        end
      end

      context 'the second word' do
        let(:word) { second_word }

        it 'should display only the first letter' do
          expect(instance.first.visible).to be_truthy
          expect(instance.rest.visible).to be_falsey
        end
      end
    end

    context 'on step three' do
      let(:step) { 3 }

      context 'the first word' do
        let(:word) { first_word }

        it 'should display only the first letter' do
          expect(instance.first.visible).to be_truthy
          expect(instance.rest.visible).to be_falsey
        end
      end

      context 'the second word' do
        let(:word) { second_word }

        it 'should display only the first letter' do
          expect(instance.first.visible).to be_truthy
          expect(instance.rest.visible).to be_falsey
        end
      end
    end

    context 'on step four' do
      let(:step) { 4 }

      context 'the first word' do
        let(:word) { first_word }

        it 'should not display any letters' do
          expect(instance.first.visible).to be_falsey
          expect(instance.rest.visible).to be_falsey
        end
      end

      context 'the second word' do
        let(:word) { second_word }

        it 'should display only the first letter' do
          expect(instance.first.visible).to be_truthy
          expect(instance.rest.visible).to be_falsey
        end
      end
    end

    context 'on step five' do
      let(:step) { 5 }

      context 'the first word' do
        let(:word) { first_word }

        it 'should not display any letters' do
          expect(instance.first.visible).to be_falsey
          expect(instance.rest.visible).to be_falsey
        end
      end

      context 'the second word' do
        let(:word) { second_word }

        it 'should not display any letters' do
          expect(instance.first.visible).to be_falsey
          expect(instance.rest.visible).to be_falsey
        end
      end
    end
  end
end
