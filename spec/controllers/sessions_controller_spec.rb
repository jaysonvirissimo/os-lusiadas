# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    context 'with bad usename/password combo' do
      let(:email) { 'fake@gmail.com' }
      let(:password) { 'wrong' }
      let(:params) { { email: email, password: password } }

      before { post :create, params: params }

      it 're-renders the login form with a warning message' do
        expect(flash.alert).to eq('Invalid email/password combination')
      end
    end
  end
end
