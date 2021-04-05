require 'rails_helper'

RSpec.describe 'Item API' do
  it "Item can be destroyed" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"
    
    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
  it 'Returns error if id not found' do
    
    delete "/api/v1/items/0"

    expect(response).not_to be_successful
    expect(response.status).to eq 404
  end
end