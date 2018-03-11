# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WordsController, type: :controller do
  describe 'POST #score' do
    context 'when not signed in' do
      let!(:word) { Fabricate(:word, value: 'armas', position: 2) }

      before { post :score, params: params }

      context 'with a correct guess' do
        let(:params) { { word_id: word.id, guess: 'armas' } }

        it { expect(response).to have_http_status(:success) }
        it { expect(json[:correct]).to be(true) }
        it { expect(json[:word_value]).to eq(word.value) }
      end

      context 'with an incorrect guess' do
        let(:params) { { word_id: word.id, guess: 'armor' } }

        it { expect(response).to have_http_status(:success) }
        it { expect(json[:correct]).to be(false) }
        it { expect(json[:word_value]).to eq(word.value) }
      end

      context 'without a good word identifier' do
        let(:params) { { word_id: 'nope' } }

        it { expect(response).to_not have_http_status(:success) }
      end
    end

    context 'when signed in' do
      let(:password) { 'abcd-1234' }
      let(:user) do
        Fabricate(:user, password: password, password_confirmation: password)
      end

      before do
        allow_any_instance_of(described_class)
          .to receive(:current_user)
          .and_return(user)
      end

      context 'for a word never seen before' do
        let(:word) { Fabricate(:word, value: 'As', position: 1) }

        context 'with a correct guess' do
          let(:params) { { guess: 'As', word_id: word.id } }

          before { post :score, params: params }

          it { expect(response).to have_http_status(:success) }
          it { expect(json[:correct]).to be(true) }
          it { expect(json[:word_value]).to eq(word.value) }
          it 'updates the users known words' do
            expect(user.words.untested).to_not include(word)
            expect(user.words.known).to include(word)
          end
        end
      end
    end
  end
end
