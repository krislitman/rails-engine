require 'rails_helper'

RSpec.describe 'Merchants with most revenue' do
  it 'Return variable number of merchants ranked by total  revenue' do
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
    invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice4 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 20.00)
    invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id, quantity: 10, unit_price: 20.00)
    invoice_item3 = create(:invoice_item, item_id: item3.id, invoice_id: invoice3.id, quantity: 10, unit_price: 20.00)
    invoice_item4 = create(:invoice_item, item_id: item4.id, invoice_id: invoice4.id, quantity: 10, unit_price: 20.00)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
    transaction2 = create(:transaction, invoice_id: invoice2.id, result: "success")
    transaction3 = create(:transaction, invoice_id: invoice3.id, result: "success")
    transaction4 = create(:transaction, invoice_id: invoice4.id, result: "success")
    # 600.0

    merchant2 = create(:merchant)
    customer2 = create(:customer)
    item5 = create(:item, merchant_id: merchant2.id)
    item6 = create(:item, merchant_id: merchant2.id)
    item7 = create(:item, merchant_id: merchant2.id)
    item8 = create(:item, merchant_id: merchant2.id)
    invoice5 = create(:invoice, customer_id: customer2.id, merchant_id: merchant2.id)
    invoice6 = create(:invoice, customer_id: customer2.id, merchant_id: merchant2.id)
    invoice7 = create(:invoice, customer_id: customer2.id, merchant_id: merchant2.id)
    invoice8 = create(:invoice, customer_id: customer2.id, merchant_id: merchant2.id)
    invoice_item5 = create(:invoice_item, item_id: item5.id, invoice_id: invoice5.id, quantity: 10, unit_price: 20.00)
    invoice_item6 = create(:invoice_item, item_id: item6.id, invoice_id: invoice6.id, quantity: 10, unit_price: 20.00)
    invoice_item7 = create(:invoice_item, item_id: item7.id, invoice_id: invoice7.id, quantity: 10, unit_price: 20.00)
    invoice_item8 = create(:invoice_item, item_id: item8.id, invoice_id: invoice8.id, quantity: 10, unit_price: 20.00)
    transaction5 = create(:transaction, invoice_id: invoice5.id, result: "success")
    transaction6 = create(:transaction, invoice_id: invoice6.id, result: "success")
    transaction7 = create(:transaction, invoice_id: invoice7.id, result: "failed")
    transaction8 = create(:transaction, invoice_id: invoice8.id, result: "failed")
    # 400

    merchant3 = create(:merchant)
    customer3 = create(:customer)
    item9 = create(:item, merchant_id: merchant3.id)
    item10 = create(:item, merchant_id: merchant3.id)
    item11 = create(:item, merchant_id: merchant3.id)
    item12 = create(:item, merchant_id: merchant3.id)
    invoice9 = create(:invoice, customer_id: customer3.id, merchant_id: merchant3.id)
    invoice10 = create(:invoice, customer_id: customer3.id, merchant_id: merchant3.id)
    invoice11 = create(:invoice, customer_id: customer3.id, merchant_id: merchant3.id)
    invoice12 = create(:invoice, customer_id: customer3.id, merchant_id: merchant3.id)
    invoice_item9 = create(:invoice_item, item_id: item9.id, invoice_id: invoice9.id, quantity: 10, unit_price: 20.00)
    invoice_item10 = create(:invoice_item, item_id: item10.id, invoice_id: invoice10.id, quantity: 10, unit_price: 20.00)
    invoice_item11 = create(:invoice_item, item_id: item11.id, invoice_id: invoice11.id, quantity: 10, unit_price: 20.00)
    invoice_item12 = create(:invoice_item, item_id: item12.id, invoice_id: invoice12.id, quantity: 10, unit_price: 20.00)
    transaction9 = create(:transaction, invoice_id: invoice9.id, result: "success")
    transaction10 = create(:transaction, invoice_id: invoice10.id, result: "success")
    transaction11 = create(:transaction, invoice_id: invoice11.id, result: "success")
    transaction12 = create(:transaction, invoice_id: invoice12.id, result: "success")
    # 800

    get "/api/v1/revenue/merchants/#{merchant.id}"

    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq 200
    expect(expected[:data][:type]).to eq('merchant_revenue')
    expect(expected[:data][:attributes][:revenue]).to eq 600.0
  end
end