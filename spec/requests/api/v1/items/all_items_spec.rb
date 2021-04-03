require 'rails_helper'

RSpec.describe "Get all items" do
  describe 'Items API' do
    it 'Get all the items, max of 20 at a time' do
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
  end