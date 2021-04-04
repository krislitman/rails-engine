require 'rails_helper'

RSpec.describe "Get all items" do
  describe 'Items API' do
    it 'Get all the items, max of 20 at a time' do
      Item.destroy_all
      create_list(:item, 20)

      get '/api/v1/items'

      found_items = JSON.parse(response.body, symbolize_names: true)
      found_items[:data].each do |item|
        expect(item[:attributes][:name]).to be_a(String)
        expect(item[:attributes][:description]).to be_a(String)
        expect(item[:attributes][:unit_price]).to be_a(Float)
      end
      expect(response).to be_successful
      expect(response.status).to eq 200
      expect(found_items[:data].count).to eq 20
      end
      it 'Returns 20 items per page' do
        Item.destroy_all
        create_list(:item, 80)

        get '/api/v1/items?per_page=50&page=2'

        found_items = JSON.parse(response.body, symbolize_names: true)
        expect(found_items[:data].length).to eq 30

        get '/api/v1/items?per_page=50&page=1'

        found_items = JSON.parse(response.body, symbolize_names: true)
        expect(found_items[:data].length).to eq 50
      end
    end
  end