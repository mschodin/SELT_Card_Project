require 'rails_helper'

RSpec.describe "Decks", type: :request do

  describe "GET /draw" do
    it "path handled correctly" do
      assert_recognizes({controller: 'deck', action: 'draw', deck_id: "1", room_id: "1"}, {path: '/room/1/deck/1/draw', method: :get})
    end
  end

  describe "GET /show" do
    it "path handled correctly" do
      assert_recognizes({controller: 'deck', action: 'show', id: "1", room_id: "1"}, {path: '/room/1/deck/1', method: :get})
    end
  end

  describe "Post index /create" do
    it "path handled correctly" do
      assert_recognizes({controller: 'deck', action: 'create', room_id: "1"}, {path: '/room/1/deck', method: :post})
    end
  end

  describe "Method /delete" do
    it "path handled correctly" do
      assert_recognizes({controller: 'deck', action: 'destroy', room_id: "1", id: "1"}, {path: '/room/1/deck/1', method: :delete})
    end
  end

  describe "GET /index" do
    it "path handled correctly" do
      assert_recognizes({controller: 'deck', action: 'index', room_id: "1"}, {path: '/room/1/deck', method: :get})
    end
  end

end
