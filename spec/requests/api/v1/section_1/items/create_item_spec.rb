require 'rails_helper'

RSpec.describe 'Item API' do
  it 'Item can be created' do
    Item.destroy_all
    Merchant.destroy_all
    merchant = create(:merchant)
    item_params = {
      name: "New Item",
      description: "Looks nice",
      unit_price: 10.99,
      merchant_id: merchant.id
    }
    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
  end
  it 'Error if attribute missing' do
    Item.destroy_all
    Merchant.destroy_all
    merchant = create(:merchant)
    item_params = {
      name: "",
      description: "Cool Empty Item",
      unit_price: 20.00,
      merchant_id: merchant.id
    }
    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    
    created_item = Item.last

    expect(response).not_to be_successful
    expect(response.status).to eq 404
  end
end