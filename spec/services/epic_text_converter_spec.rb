# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EpicTextConverter do
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

  it { expect(subject).to respond_to(:convert) }
  it { expect(described_class).to respond_to(:convert) }

  it 'should populate the database with cantos' do
    expect { subject.convert }.to change { Canto.count }.from(0).to(10)
  end
  it 'should populate the database with stanzas' do
    expect { subject.convert }.to change { Stanza.count }.from(0).to(2)
  end

  describe 'should properly associate stanzas with cantos' do
    let(:primeiro) { Canto.find_by(number: 1) }
    let(:segundo) { Canto.find_by(number: 2) }

    before { subject.convert }

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
  end
end
