# frozen_string_literal: true

require 'rails_helper'

describe NavPresenter do
  describe '#html' do
    context 'before a user has signed in' do
      let(:html) { subject.html }
      let!(:line) { Fabricate(:line, absolute_number: 1) }

      it 'displays the correct HTML' do
        expect(html).to include('<nav class="navbar" role="navigation" aria-label="main navigation">')
        expect(html).to include('<div class="navbar-brand">')
        expect(html).to include('<a class="navbar-item" href="/">MemorizeOnline</a>')
        expect(html).to include("<a class=\"navbar-item\" href=\"/lines/read?id=#{line.id}\">Learn</a>")
        expect(html).to include('<a class="navbar-item" disabled="disabled" href="/lines/read">Review (0)</a>')
        expect(html).to include('<a class="navbar-item" href="/users/new">Sign Up</a>')
        expect(html).to include('<a class="navbar-item" href="/sessions/new">Sign In</a>')
        expect(html).to include('</div>')
        expect(html).to include('</nav>')
      end
    end
  end
end
