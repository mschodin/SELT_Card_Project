require 'rails_helper'

RSpec.describe "Decks", type: :request do

  describe "GET /draw" do
    it "returns http success" do
      get "/Deck/draw"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/Deck/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/Deck/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/Deck/delete"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/Deck/index"
      expect(response).to have_http_status(:success)
    end
  end

end
