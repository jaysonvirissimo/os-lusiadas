# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#create' do
    let(:email) { 'fakey@mail.net' }
    let(:password) { 'Password123' }
    let(:parameters) do
      {
        name: name,
        email: email,
        password: password,
        password_confirmation: password
      }
    end
    subject { post :create, params: { user: parameters } }

    context 'with valid user parameters' do
      let(:name) { 'Fakey McFakeson' }

      it 'passes no errors to flash' do
        subject
        expect(flash.alert).to be_blank
      end
    end

    context 'with invalid user parameters' do
      let(:name) { nil }

      it 'passes errors to flash' do
        subject
        expect(flash.alert).to_not be_blank
      end
    end
  end

  describe '#destroy' do
    context 'when signed in' do
      let(:id) { user.id }
      let(:user) { Fabricate(:user) }
      subject { delete :destroy, params: { id: id } }

      before do
        allow_any_instance_of(described_class)
          .to receive(:current_user)
          .and_return(user)
      end

      it 'deletes the given user' do
        expect(User.find_by(id: id)).to be
        expect(subject).to redirect_to(root_url)
        expect(User.find_by(id: id)).to_not be
      end
    end
  end
end
