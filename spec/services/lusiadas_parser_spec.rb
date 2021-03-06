# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LusiadasParser do
  let(:string) do
    <<~HEREDOC
      Canto Primeiro

      1
      As armas e os barões assinalados,
      Que da ocidental praia Lusitana,
      Por mares nunca de antes navegados,
      Passaram ainda além da Taprobana,
      Em perigos e guerras esforçados,
      Mais do que prometia a força humana,
      E entre gente remota edificaram
      Novo Reino, que tanto sublimaram;

      Canto Segundo

      2
      Já neste tempo o lúcido Planeta,
      Que as horas vai do dia distinguindo,
      Chegava à desejada e lenta meta,
      A luz celeste às gentes encobrindo,
      E da casa marítima secreta
      Lhe estava o Deus Noturno a porta abrindo,
      Quando as infidas gentes se chegaram
      As naus, que pouco havia que ancoraram.
    HEREDOC
  end

  subject { described_class.new(string) }

  it { expect(subject).to respond_to(:call) }
  it { expect(described_class).to respond_to(:call) }

  it 'should populate the database with cantos' do
    expect { subject.call }.to change { Canto.count }.from(0).to(10)
  end
  it 'should populate the database with stanzas' do
    expect { subject.call }.to change { Stanza.count }.from(0).to(2)
  end

  describe 'should properly associate stanzas with cantos' do
    let(:primeiro) { Canto.find_by(number: 1) }
    let(:segundo) { Canto.find_by(number: 2) }

    before { subject.call }

    it { expect(primeiro).to be }
    it { expect(primeiro.name).to eq('Canto Primeiro') }
    it { expect(primeiro.stanzas).to_not be_empty }
    it { expect(primeiro.stanzas.first.number).to eq(1) }
    it { expect(segundo).to be }
    it { expect(segundo.name).to eq('Canto Segundo') }
    it { expect(segundo.stanzas).to_not be_empty }
    it { expect(segundo.stanzas.first.number).to eq(2) }

    describe 'and words with lines' do
      let(:first_line) { primeiro.stanzas.first.lines.find_by(number: 1) }
      let(:words) { first_line.words }

      it { expect(first_line).to be }
      it { expect(words).to_not be_empty }
      it { expect(words.find_by(position: 1).value).to eq('As') }
      it { expect(words.find_by(position: 6).value).to eq('assinalados,') }
    end

    describe 'and record relative and absolute position of words' do
      let(:first_word) do
        Word.find_by(position: 1, absolute_position: 1)
      end
      let(:last_word) do
        Word.find_by(position: 7, absolute_position: 95)
      end

      it { expect(first_word.value).to eq('As') }
      it { expect(last_word.value).to eq('ancoraram.') }
    end

    it 'should record relative and absolute number of lines' do
      expect(Line.find_by(number: 1, absolute_number: 1)).to be
      expect(Line.find_by(number: 8, absolute_number: 16)).to be
    end
  end
end
