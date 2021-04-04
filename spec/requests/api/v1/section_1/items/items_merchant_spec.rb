require 'rails_helper'

RSpec.describe 'Items Merchant API' do
  it 'Returns a 404 with no merchant found' do
    Item.destroy_all
    Merchant.destroy_all
    
    get "/api/v1/items/100/merchant"
    
    expect(response).not_to be_successful
    expect(response.status).to eq 404
  end
  it 'Finds merchant' do
    Item.destroy_all
    Merchant.destroy_all
    merchant = create(:merchant)
    items = create_list(:item, 30, merchant_id: merchant.id)

    get "/api/v1/items/#{items.first.id}/merchant"

    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(expected.length).to eq 1
    expect(expected[:data][:attributes][:name]).to eq(merchant.name)
  end
end