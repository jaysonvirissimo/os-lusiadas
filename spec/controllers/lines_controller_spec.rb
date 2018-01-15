require 'rails_helper'

RSpec.describe LinesController, type: :controller do

  describe "GET #read" do
    it "returns http success" do
      get :read
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #recall" do
    it "returns http success" do
      get :recall
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
