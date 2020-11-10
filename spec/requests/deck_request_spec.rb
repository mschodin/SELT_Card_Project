require 'rails_helper'

RSpec.describe "Decks", type: :request do

  describe "GET /draw" do
    it "returns http success" do
      get "/deck/draw"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/deck/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/deck/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/deck/delete"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/deck/index"
      expect(response).to have_http_status(:success)
    end
  end

end
