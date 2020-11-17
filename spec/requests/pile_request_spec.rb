require 'rails_helper'

RSpec.describe "Piles", type: :request do

  describe "POST /create" do
    it "path handled correctly" do
      assert_recognizes({controller: 'pile', action: 'create', room_id: "1"}, {path: '/room/1/pile', method: :post})
    end
  end

end
