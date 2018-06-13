# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'End-to-end master test', type: :system do
  let(:canto) { Fabricate(:canto, name: 'Canto Primeiro', number: 1) }
  let(:email) { 'consulado.sfrancisco@mne.pt' }
  let(:line) do
    Fabricate(:line, in_english: 'The weapons and the barons,')
  end
  let(:name) { 'Vasco da Gama' }
  let(:stanza) { Fabricate(:stanza, canto: canto, lines: [line]) }
  let(:words) do
    Fabricate(:word, value: 'As', line: line, position: 1)
    Fabricate(:word, value: 'armas', line: line, position: 2)
    Fabricate(:word, value: 'e', line: line, position: 3)
    Fabricate(:word, value: 'os', line: line, position: 4)
    Fabricate(:word, value: 'barões', line: line, position: 5)
    Fabricate(:word, value: 'assinalados,', line: line, position: 6)
  end

  before { driven_by(:rack_test) }

  it 'guards against regressions for a stereotypical user session' do
    canto and stanza and line and words

    visit root_url
    expect(page).to have_text 'MemorizeOnline'

    click_button 'close-modal-button'

    click_link 'Sign Up'
    expect(page).to have_text 'Name'
    expect(page).to have_text 'Email'
    expect(page).to have_text 'Password'

    fill_in 'Name', with: name
    fill_in 'Email', with: email
    fill_in 'Password', with: 'abcd1234'
    fill_in 'Password confirmation', with: 'abcd1234'
    click_button 'Create User'
    expect(page).to have_text name
    expect(page).to have_text email
    expect(page).to have_text 'Edit'
    expect(page).to have_text 'Delete'
    expect(page).to have_text 'Learn'

    click_link 'Learn'
    expect(page).to have_text 'Canto Primeiro'
    expect(page).to have_text 'Stanza 1'
    expect(page).to have_text 'The weapons and the barons,'
    expect(page).to have_text 'As armas e os barões assinalados,'

    click_link 'Settings'
    click_link 'Edit'
    expect(page).to have_text 'Display English translations while reading'
  end
end
