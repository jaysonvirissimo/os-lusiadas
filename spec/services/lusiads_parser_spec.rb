# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LusiadsParser do
  let(:string) do
    <<~HEREDOC
      CANTO I

      THE FEATS of Arms, and famed heroick Host,
        from occidental Lusitanian strand,
        *        *        *        *        *
      who o’er the waters ne’er by seaman crost,
        farèd beyond the Taprobane-land,
      forceful in perils and in battle-post,	        5
        with more than promised force of mortal hand;
      and in the regions of a distant race
      rear’d a new throne so haught in Pride of Place:
    HEREDOC
  end

  describe 'should match each English line with the Portuguese analog' do
    let(:first_line) { Line.find_by(absolute_number: 1) }
    let(:fifth_line) { Line.find_by(absolute_number: 5) }

    before do
      8.times { |index| Fabricate(:line, absolute_number: index + 1) }
      described_class.new(string).call
    end

    it 'and update the existing line records' do
      expect(first_line.english_translation).to start_with('THE FEATS of Arms,')
      expect(fifth_line.english_translation).to end_with('battle-post,')
    end
  end
end
