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

      1
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
end
