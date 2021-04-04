require 'rails_helper'

RSpec.describe "Gets one merchant" do
  before :each do
    Merchant.destroy_all
    @merchants = create_list(:merchant, 20)
  end
  describe 'Merchants API' do
      it 'Returns a single merchant by id' do
      get "/api/v1/merchants/#{@merchants.first.id}"

      @found_merchant = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      expect(response.status).to eq 200
      expect(@found_merchant).to be_a Hash
    end
  end
end