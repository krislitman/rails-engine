require 'rails_helper'

RSpec.describe 'Item API' do
  it 'Item can be created' do
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
end