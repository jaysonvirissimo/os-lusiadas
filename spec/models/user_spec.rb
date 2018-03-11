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
