# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:email) { 'camões@macau.cn' }
  let(:password) { '1234-abcd' }

  context 'without a name' do
    let(:name) { nil }
    let(:instance) do
      User.new(
        email: email,
        name: name,
        password: password,
        password_confirmation: password
      )
    end

    it { expect(instance).to_not be_valid }
  end
end
