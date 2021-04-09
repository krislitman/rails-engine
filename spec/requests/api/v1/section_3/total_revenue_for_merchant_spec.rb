require 'rails_helper'

RSpec.describe 'Total revenue for a merchant' do
  it 'Can return a merchants total revenue based on merchant id' do
    Merchant.destroy_all
    Item.destroy_all
    Invoice.destroy_all
    Transaction.destroy_all
    Customer.destroy_all
    InvoiceItem.destroy_all
    merchant = create(:merchant)
    customer = create(:customer)
    item1 = create(:item, merchant_id: merchant.id)
    item2 = create(:item, merchant_id: merchant.id)
    item3 = create(:item, merchant_id: merchant.id)
    item4 = create(:item, merchant_id: merchant.id)
    invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, status: 'shipped')
    invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, status: 'shipped')
    invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, status: 'shipped')
    invoice4 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, status: 'shipped')
    invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 20.00)
    invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id, quantity: 10, unit_price: 20.00)
    invoice_item3 = create(:invoice_item, item_id: item3.id, invoice_id: invoice3.id, quantity: 10, unit_price: 20.00)
    invoice_item4 = create(:invoice_item, item_id: item4.id, invoice_id: invoice4.id, quantity: 10, unit_price: 20.00)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
    transaction2 = create(:transaction, invoice_id: invoice2.id, result: "success")
    transaction3 = create(:transaction, invoice_id: invoice3.id, result: "success")
    transaction4 = create(:transaction, invoice_id: invoice4.id, result: "failed")

    get "/api/v1/revenue/merchants/#{merchant.id}"
    
    expected = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
    expect(response.status).to eq 200
    expect(expected[:data][:type]).to eq('merchant_revenue')
    expect(expected[:data][:attributes][:revenue]).to eq 600.0
  end
  it 'Should return error if no merchant given' do
    
    get "/api/v1/revenue/merchants/0"

    expect(response).not_to be_successful
    expect(response.status).to eq 404
  end
  it 'Should return error if param is string' do
    
    get "/api/v1/revenue/merchants/WHATTT"

    expect(response).not_to be_successful
    expect(response.status).to eq 404
  end
end