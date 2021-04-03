require 'rails_helper'

RSpec.describe "Get all merchants" do
  describe 'Merchants API' do
    it 'Get all the merchants' do
      Merchant.destroy_all
      create_list(:merchant, 20)

      get '/api/v1/merchants'

      found_merchants = JSON.parse(response.body, symbolize_names: true)
      found_merchants[:data].each do |merchant|
        expect(merchant[:attributes][:name]).to be_a(String)
      end
      expect(response).to be_successful
      expect(response.status).to eq 200
      expect(found_merchants[:data].count).to eq 20
    end
    it 'Returns 20 merchants per page' do
      Merchant.destroy_all
      create_list(:merchant, 100)

      get '/api/v1/merchants?per_page=50&page=2'

      found_merchants = JSON.parse(response.body, symbolize_names: true)
      expect(found_merchants[:data].length).to eq 50
    end
    it 'Returns array if no resources found' do
      Merchant.destroy_all
      
      get '/api/v1/merchants'

      found_merchants = JSON.parse(response.body, symbolize_names: true)
      expect(found_merchants[:data]).to be_an Array
    end
  end
end