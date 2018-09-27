# frozen_string_literal: true

require 'rails_helper'

describe FlashPresenter do
  describe '#html' do
    let(:html) { described_class.new(flash).html }
    let(:flash) { double(alert: 'Danger Will Robinson') }

    it 'displays the correct HTML' do
      expect(html).to include('<article class="message is-warning">')
      expect(html).to include('<div class="message-header">')
      expect(html).to include('<p>Warning</p>')
      expect(html).to include('<button class="delete" aria-label="delete"></button>')
      expect(html).to include('<div class="message-body">')
      expect(html).to include('Danger Will Robinson')
      expect(html).to include('</div>')
      expect(html).to include('</article>')
    end
  end
end
