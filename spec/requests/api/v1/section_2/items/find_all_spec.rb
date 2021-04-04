require 'rails_helper'

RSpec.describe 'Item API' do
  it 'Returns items with matching description or name' do
    Merchant.destroy_all
    Item.destroy_all
    merchant = create(:merchant)
    items1 = create_list(:item, 10, name: "sweet items", merchant_id: merchant.id)
    items2 = create_list(:item, 10, name: "really sweet description", merchant_id: merchant.id)

    get "/api/v1/items/find_all?name=sweet"

    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq 200
    expect(expected[:data].length).to eq 20
  end
  it 'Returns items with a min_price' do
    Merchant.destroy_all
    Item.destroy_all
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 2.00, merchant_id: merchant.id)
    item2 = create(:item, unit_price: 6.00, merchant_id: merchant.id)
    item3 = create(:item, unit_price: 20.99, merchant_id: merchant.id)
    item4 = create(:item, unit_price: 3.50, merchant_id: merchant.id)
    
    get "/api/v1/items/find_all?min_price=4.99"
    
    expected = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
    expect(response.status).to eq 200
    expect(expected[:data].length).to eq 2
  end
  it 'Returns items with a max_price' do
    Merchant.destroy_all
    Item.destroy_all
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 2.00, merchant_id: merchant.id)
    item2 = create(:item, unit_price: 6.00, merchant_id: merchant.id)
    item3 = create(:item, unit_price: 20.99, merchant_id: merchant.id)
    item4 = create(:item, unit_price: 3.50, merchant_id: merchant.id)

    get "/api/v1/items/find_all?max_price=10.00"

    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq 200
    expect(expected[:data].length).to eq 3
  end
  it 'Returns items with both a min & maxprice' do
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 2.00, merchant_id: merchant.id)
    item2 = create(:item, unit_price: 6.00, merchant_id: merchant.id)
    item3 = create(:item, unit_price: 20.99, merchant_id: merchant.id)
    item4 = create(:item, unit_price: 3.50, merchant_id: merchant.id)
    item4 = create(:item, unit_price: 30.00, merchant_id: merchant.id)

    get "/api/v1/items/find_all?min_price=2.50&max_price=22.00"

    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq 200
    expect(expected[:data].length).to eq 3
  end
  it 'Should error out if name and price are sent' do
    merchant = create(:merchant)
    items1 = create_list(:item, 10, name: "sweet items", merchant_id: merchant.id)
    items2 = create_list(:item, 10, name: "really sweet description", merchant_id: merchant.id)

    get "/api/v1/items/find_all?name=sweet&max_price=10.00"

    expect(response).not_to be_successful
    expect(response.status).to eq 404
  end
  it 'Should error out if both name and price min/max are sent' do
    merchant = create(:merchant)
    items1 = create_list(:item, 10, name: "sweet items", merchant_id: merchant.id)
    items2 = create_list(:item, 10, name: "really sweet description", merchant_id: merchant.id)

    get "/api/v1/items/find_all?name=sweet&min_price=3.50&max_price=10.00"

    expect(response).not_to be_successful
    expect(response.status).to eq 404
  end
end