require 'rails_helper'

RSpec.describe "Get all merchants" do
  before :each do
    Merchant.destroy_all
    @merchants = create_list(:merchant, 20)
  end
  describe 'Merchants API' do
      it 'Get all the merchants' do
      get '/api/v1/merchants'

      @found_merchants = JSON.parse(response.body, symbolize_names: true)
      @found_merchants[:data].each do |merchant|
        expect(merchant[:attributes][:name]).to be_a(String)
    
      end
      expect(response).to be_successful
      expect(response.status).to eq 200
      expect(@found_merchants[:data].count).to eq 20
    end
  end
end