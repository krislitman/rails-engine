require 'rails_helper'

RSpec.describe 'Report of orders which have not shipped' do
  before :each do 
    Merchant.destroy_all
    Item.destroy_all
    Invoice.destroy_all
    Transaction.destroy_all
    Customer.destroy_all
    InvoiceItem.destroy_all
    @merchant = create(:merchant)
    @customer = create(:customer)
    @item1 = create(:item)
    @invoice1 = create(:invoice, merchant_id: @merchant.id, customer_id: @customer.id, status: 'failed')
    @transaction1 = create(:transaction, invoice_id: @invoice1.id)
    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, quantity: 20, unit_price: 20.00)
    # should return, revenue = 400.0
    @merchant2 = create(:merchant)
    @customer2 = create(:customer)
    @item2 = create(:item)
    @invoice2 = create(:invoice, merchant_id: @merchant2.id, customer_id: @customer2.id, status: 'shipped')
    @transaction2 = create(:transaction, invoice_id: @invoice2.id)
    @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice2.id, quantity: 40, unit_price: 40.00)
    # should NOT return, revenue = 1600.0
    @merchant3 = create(:merchant)
    @customer3 = create(:customer)
    @item3 = create(:item)
    @invoice3 = create(:invoice, merchant_id: @merchant3.id, customer_id: @customer3.id, status: 'failed')
    @transaction3 = create(:transaction, invoice_id: @invoice3.id)
    @invoice_item3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice3.id, quantity: 40, unit_price: 20.00)
    # should return, revenue = 800.0
    @merchant4 = create(:merchant)
    @customer4 = create(:customer)
    @item4 = create(:item)
    @invoice4 = create(:invoice, merchant_id: @merchant4.id, customer_id: @customer4.id, status: 'failed')
    @transaction4 = create(:transaction, invoice_id: @invoice4.id)
    @invoice_item4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice4.id, quantity: 5, unit_price: 20.00)
    # should return, revenue = 100.0
    @merchant5 = create(:merchant)
    @customer5 = create(:customer)
    @item5 = create(:item)
    @invoice5 = create(:invoice, merchant_id: @merchant5.id, customer_id: @customer5.id, status: 'failed')
    @transaction5 = create(:transaction, invoice_id: @invoice5.id)
    @invoice_item5 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice5.id, quantity: 6, unit_price: 20.00)
    # should return, revenue = 120.0
    @merchant6 = create(:merchant)
    @customer6 = create(:customer)
    @item6 = create(:item)
    @invoice6 = create(:invoice, merchant_id: @merchant6.id, customer_id: @customer6.id, status: 'failed')
    @transaction6 = create(:transaction, invoice_id: @invoice6.id)
    @invoice_item6 = create(:invoice_item, item_id: @item6.id, invoice_id: @invoice6.id, quantity: 7, unit_price: 20.00)
    # should return, revenue = 140.0
    @merchant7 = create(:merchant)
    @customer7 = create(:customer)
    @item7 = create(:item)
    @invoice7 = create(:invoice, merchant_id: @merchant7.id, customer_id: @customer7.id, status: 'failed')
    @transaction7 = create(:transaction, invoice_id: @invoice7.id)
    @invoice_item7 = create(:invoice_item, item_id: @item7.id, invoice_id: @invoice7.id, quantity: 8, unit_price: 20.00)
    # should return, revenue = 160.0
    @merchant8 = create(:merchant)
    @customer8 = create(:customer)
    @item8 = create(:item)
    @invoice8 = create(:invoice, merchant_id: @merchant8.id, customer_id: @customer8.id, status: 'failed')
    @transaction8 = create(:transaction, invoice_id: @invoice8.id)
    @invoice_item8 = create(:invoice_item, item_id: @item8.id, invoice_id: @invoice8.id, quantity: 9, unit_price: 20.00)
    # should return, revenue = 180.0
    @merchant9 = create(:merchant)
    @customer9 = create(:customer)
    @item9 = create(:item)
    @invoice9 = create(:invoice, merchant_id: @merchant9.id, customer_id: @customer9.id, status: 'failed')
    @transaction9 = create(:transaction, invoice_id: @invoice9.id)
    @invoice_item9 = create(:invoice_item, item_id: @item9.id, invoice_id: @invoice9.id, quantity: 1, unit_price: 40.00)
    # should return, revenue = 40.0
    @merchant10 = create(:merchant)
    @customer10 = create(:customer)
    @item10 = create(:item)
    @invoice10 = create(:invoice, merchant_id: @merchant10.id, customer_id: @customer10.id, status: 'failed')
    @transaction10 = create(:transaction, invoice_id: @invoice10.id)
    @invoice_item10 = create(:invoice_item, item_id: @item10.id, invoice_id: @invoice10.id, quantity: 2, unit_price: 40.00)
    # should return, revenue = 80.0
    @merchant11 = create(:merchant)
    @customer11 = create(:customer)
    @item11 = create(:item)
    @invoice11 = create(:invoice, merchant_id: @merchant11.id, customer_id: @customer11.id, status: 'failed')
    @transaction11 = create(:transaction, invoice_id: @invoice11.id)
    @invoice_item11 = create(:invoice_item, item_id: @item11.id, invoice_id: @invoice11.id, quantity: 1, unit_price: 50.00)
    # should return, revenue = 50.0
  end
  describe 'Ranked by total revenue DESC' do
    it 'Should error out if integer is not greater than 0' do

      get '/api/v1/revenue/unshipped?quantity=0'

      expect(response).not_to be_successful
      expect(response.status).to eq 400
    end
    it 'Should default to 10 orders returned if no param given' do
      
      get '/api/v1/revenue/unshipped'

      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq 200
      expect(expected[:data].length).to eq 10
      expect(expected[:data][0][:id].to_i).to eq(@invoice3.id)
      expect(expected[:data].last[:id].to_i).to eq(@invoice9.id)
    end
    it 'Can return any quantity of orders' do

      get '/api/v1/revenue/unshipped?quantity=7'

      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq 200
      expect(expected[:data].length).to eq 7
      expect(expected[:data][0][:id].to_i).to eq(@invoice3.id)
    end
    it 'Can return orders even if quantity is really high' do

      get '/api/v1/revenue/unshipped?quantity=100'

      expected = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq 200
      expect(expected[:data].length).to eq 10
      expect(expected[:data][0][:id].to_i).to eq(@invoice3.id)
    end
  end
end