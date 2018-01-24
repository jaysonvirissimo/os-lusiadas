require 'rails_helper'

RSpec.describe LinesController, type: :controller do
  describe "GET #review" do
    let!(:word) { Fabricate(:word) }

    it "returns http success" do
      get :review, params: { id: word.line.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #test" do
    it "returns http success" do
      get :test
      expect(response).to have_http_status(:success)
    end
  end
end
