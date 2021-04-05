require 'rails_helper'

RSpec.describe 'Item API' do
  it 'Item can be updated' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    previous_name = Item.last.name
    item_params = { name: "New Item Name" }
    headers = { 'Content-Type' => 'application/json' }
    
    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate({item: item_params})
    expected = Item.find_by(id: item.id)
    
    expect(response).to be_successful
    expect(expected.name).not_to eq(previous_name)
    expect(expected.name).to eq("New Item Name")
  end
  it 'Returns an error if invalid item id is given' do
    item_params = { name: "New Item Name" }
    patch "/api/v1/items/0", headers: headers, params: JSON.generate({item: item_params})

    expect(response).not_to be_successful
    expect(response.status).to eq 404
  end
end