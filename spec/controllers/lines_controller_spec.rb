# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinesController, type: :controller do
  let!(:word) { Fabricate(:word) }
  describe 'GET #review' do
    it 'returns http success' do
      get :review, params: { number: word.line.number }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #test' do
    it 'returns http success' do
      get :test, params: { number: word.line.number }
      expect(response).to have_http_status(:success)
    end
  end
end
