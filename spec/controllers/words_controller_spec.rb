# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WordsController, type: :controller do
  describe 'POST #score' do
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
end
