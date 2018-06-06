# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'End-to-end master test', type: :system do
  let(:email) { 'consulado.sfrancisco@mne.pt' }
  let(:name) { 'Vasco da Gama' }
  before { driven_by(:rack_test) }

  it 'guards against regressions for a stereotypical user interaction' do
    visit root_url
    expect(page).to have_text 'MemorizeOnline'

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
  end
end
