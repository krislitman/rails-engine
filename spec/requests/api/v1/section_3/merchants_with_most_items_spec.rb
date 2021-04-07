require 'rails_helper'

RSpec.describe 'Endpoint to return variable number of merchants' do
  describe 'Ranked by total number of items sold' do
    it 'Errors out when quantity is not greater than 0' do
      get '/api/v1/merchants/most_items?quantity=0'

      expect(response).not_to be_successful
      expect(response.status).to eq 400
    end
      it 'Returns 5 as default when no quantity is given' do
      merchant1 = create(:merchant)
      customer = create(:customer)
      item1 = create(:item, merchant_id: merchant1.id)
      invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
      invoice_items1 = create_list(:invoice_item, 10, item_id: item1.id, invoice_id: invoice1.id)

      merchant2 = create(:merchant)
      item2 = create(:item, merchant_id: merchant2.id)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
      invoice_items2 = create_list(:invoice_item, 20, item_id: item2.id, invoice_id: invoice2.id)

      merchant3 = create(:merchant)
      item3 = create(:item, merchant_id: merchant3.id)
      invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant3.id)
      invoice_items3 = create_list(:invoice_item, 30, item_id: item3.id, invoice_id: invoice3.id)
      
      merchant4 = create(:merchant)
      item4 = create(:item, merchant_id: merchant4.id)
      invoice4 = create(:invoice, customer_id: customer.id, merchant_id: merchant4.id)
      invoice_items4 = create_list(:invoice_item, 40, item_id: item4.id, invoice_id: invoice4.id)

      merchant5 = create(:merchant)
      item5 = create(:item, merchant_id: merchant5.id)
      invoice5 = create(:invoice, customer_id: customer.id, merchant_id: merchant5.id)
      invoice_items5 = create_list(:invoice_item, 50, item_id: item5.id, invoice_id: invoice5.id)

      merchant6 = create(:merchant)
      item6 = create(:item, merchant_id: merchant6.id)
      invoice6 = create(:invoice, customer_id: customer.id, merchant_id: merchant6.id)
      invoice_items6 = create_list(:invoice_item, 60, item_id: item6.id, invoice_id: invoice6.id)
      

      get '/api/v1/merchants/most_items'

      expected = JSON.parse(response.body, symbolize_names: true)

      expect(expected[:data].length).to eq 5
      end
  
      it 'Returns more than 5'
  end
end