require 'rails_helper'

RSpec.describe 'Total revenue for a merchant' do
  it 'Can return a merchants total revenue based on merchant id' do
    merchant = create(:merchant)
    customer = create(:customer)
    item1 = create(:item, merchant_id: merchant.id)
    item2 = create(:item, merchant_id: merchant.id)
    item3 = create(:item, merchant_id: merchant.id)
    item4 = create(:item, merchant_id: merchant.id)
    invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice4 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 20.00)
    invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id, quantity: 10, unit_price: 20.00)
    invoice_item3 = create(:invoice_item, item_id: item3.id, invoice_id: invoice3.id, quantity: 10, unit_price: 20.00)
    invoice_item4 = create(:invoice_item, item_id: item4.id, invoice_id: invoice4.id, quantity: 10, unit_price: 20.00)

    get "/api/v1/revenue/merchants/#{merchant.id}"

    expected = JSON.parse(response.body, symbolize_names: true)

    expect(responst).to be_successful
    expect(response.status).to eq 200
    expect(expected[:data][:type]).to eq('merchant_revenue')
    expect(expected[:data][:attributes][:revenue]).to eq 800.00
  end
end