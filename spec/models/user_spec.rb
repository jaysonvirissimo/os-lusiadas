# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:email) { 'camões@macau.cn' }
  let(:name) { 'Luís de Camões' }
  let(:password) { '1234-abcd' }
  let(:instance) do
    User.new(
      email: email,
      name: name,
      password: password,
      password_confirmation: password
    )
  end

  describe '#next_line_to_learn' do
    let(:line) { Fabricate(:line, number: 1) }
    let(:expected_line) { Fabricate(:line, number: 2) }
    let(:word) { Fabricate(:word, absolute_position: 1) }
    let(:other_word) { Fabricate(:word, absolute_position: 2) }
    let(:next_word) do
      Fabricate(:word, absolute_position: 3, line: expected_line)
    end
    let(:user) { Fabricate(:user) }

    it 'finds the line associated with the next absolutely positioned word' do
      word && other_word && next_word
      user.words << word
      user.words << other_word
      expect(user.next_line_to_learn).to eq(expected_line)
    end
  end

  context 'with email, name, and password' do
    it { expect(instance).to be_valid }
  end

  context 'without a name' do
    let(:name) { nil }

    it { expect(instance).to_not be_valid }
  end

  context 'without an email' do
    let(:email) { nil }

    it { expect(instance).to_not be_valid }
  end

  context 'with an existing user for that email' do
    let(:existing_user) { Fabricate(:user, email: email) }

    it 'does not allow another user with the same email' do
      existing_user && instance.save
      expect(instance).to_not be_valid
    end
  end
end
