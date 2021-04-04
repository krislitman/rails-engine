require 'rails_helper'

RSpec.describe 'Item API' do
  it 'Returns items with matching description or name' do
    merchant = create(:merchant)
    items1 = create_list(:item, 10, name: "sweet items", merchant_id: merchant.id)
    items2 = create_list(:item, 10, description: "really sweet description", merchant_id: merchant.id)

    get "/api/v1/items/find_all?name=sweet"

    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq 200
    expect(expected[:data].length).to eq 20
  end
end