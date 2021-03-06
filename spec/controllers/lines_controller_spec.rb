# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinesController, type: :controller do
  let!(:word) { Fabricate(:word) }
  describe 'GET #read' do
    it 'returns http success' do
      get :read, params: { id: word.line.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #test' do
    it 'returns http success' do
      get :test, params: { id: word.line.id }
      expect(response).to have_http_status(:success)
    end
  end
end
