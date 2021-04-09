require 'rails_helper'

RSpec.describe MerchantFacade do
  describe 'Class Methods' do
    it '#items_sold' do
      Merchant.destroy_all
      Item.destroy_all
      Invoice.destroy_all
      Transaction.destroy_all
      Customer.destroy_all
      InvoiceItem.destroy_all
      merchant1 = create(:merchant)
      customer = create(:customer)
      item1 = create(:item, merchant_id: merchant1.id)
      invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
      invoice_items1 = create_list(:invoice_item, 10, item_id: item1.id, invoice_id: invoice1.id, quantity: 10)
      transaction1 = create(:transaction, invoice_id: invoice1.id)

      merchant2 = create(:merchant)
      item2 = create(:item, merchant_id: merchant2.id)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
      invoice_items2 = create_list(:invoice_item, 20, item_id: item2.id, invoice_id: invoice2.id, quantity: 20)
      transaction2 = create(:transaction, invoice_id: invoice2.id)

      expected = Merchant.items_sold(1)

      expect(expected.length).to eq 1
      expect(expected[0].name).to eq(merchant2.name)
    end
    it '#merchants_by_revenue' do
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
      transaction4 = create(:transaction, invoice_id: invoice4.id, result: "success")
      # 600.0
  
      merchant2 = create(:merchant)
      customer2 = create(:customer)
      item5 = create(:item, merchant_id: merchant2.id)
      item6 = create(:item, merchant_id: merchant2.id)
      item7 = create(:item, merchant_id: merchant2.id)
      item8 = create(:item, merchant_id: merchant2.id)
      invoice5 = create(:invoice, customer_id: customer2.id, merchant_id: merchant2.id, status: 'shipped')
      invoice6 = create(:invoice, customer_id: customer2.id, merchant_id: merchant2.id, status: 'shipped')
      invoice7 = create(:invoice, customer_id: customer2.id, merchant_id: merchant2.id, status: 'shipped')
      invoice8 = create(:invoice, customer_id: customer2.id, merchant_id: merchant2.id, status: 'shipped')
      invoice_item5 = create(:invoice_item, item_id: item5.id, invoice_id: invoice5.id, quantity: 10, unit_price: 20.00)
      invoice_item6 = create(:invoice_item, item_id: item6.id, invoice_id: invoice6.id, quantity: 10, unit_price: 20.00)
      invoice_item7 = create(:invoice_item, item_id: item7.id, invoice_id: invoice7.id, quantity: 10, unit_price: 20.00)
      invoice_item8 = create(:invoice_item, item_id: item8.id, invoice_id: invoice8.id, quantity: 10, unit_price: 20.00)
      transaction5 = create(:transaction, invoice_id: invoice5.id, result: "success")
      transaction6 = create(:transaction, invoice_id: invoice6.id, result: "success")
      transaction7 = create(:transaction, invoice_id: invoice7.id, result: "failed")
      transaction8 = create(:transaction, invoice_id: invoice8.id, result: "failed")
      # 400

      expected = Merchant.by_revenue(1)

      expect(expected.length).to eq 1
      expect(expected[0].name).to eq(merchant.name)
    end
    it '#total_revenue' do
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

      expected = merchant.total_revenue
      
      expect(expected).to eq 600.0
    end
    it '#all_merchants' do
      Merchant.destroy_all
      create_list(:merchant, 30)

      page1 = "1"
      page2 = "2"
      per_page = "20"

      expected1 = Merchant.pagination(page1, per_page)
      expected2 = Merchant.pagination(page2, per_page)

      expect(expected1.length).to eq 20
      expect(expected2.length).to eq 10
    end
    it '#search' do
      Merchant.destroy_all
      create_list(:merchant, 30)
      merchant = create(:merchant)

      expected1 = Merchant.search(merchant.name)

      expect(expected1.length).to eq 1
      expect(expected1[0].name).to eq(merchant.name)
    end
  end
end