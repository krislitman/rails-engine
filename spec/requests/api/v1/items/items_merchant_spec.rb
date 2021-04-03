require 'rails_helper'

RSpec.describe 'Items Merchant API' do
  it 'Returns a 404 with no item found' do
    Item.destroy_all
    Merchant.destroy_all
    
    get "/api/v1/items/100/merchant"
    
    expect(response).not_to be_successful
    expect(response.status).to eq 404
  end
  # it 'Finds all items for merchant' do
  #   Item.destroy_all
  #   Merchant.destroy_all
  #   merchant = create(:merchant)
  #   items = create_list(:item, 30, merchant_id: merchant.id)

  #   get "/api/v1/merchants/#{merchant.id}/items"

  #   found_items = JSON.parse(response.body, symbolize_names: true)
    
  #   expect(response).to be_successful
  #   expect(found_items[:data].length).to eq 30
  # end
end