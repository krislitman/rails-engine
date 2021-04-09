require 'rails_helper'

RSpec.describe InvoiceFacade do
  describe 'Class Methods' do
    it '#potential_revenue' do
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
      quantity = 1
      expected = InvoiceFacade.potential_revenue(quantity)
      
      expect(expected.length).to eq 1
      expect(expected[0].revenue).to eq 800.0
      
      quantity2 = 2
      expected2 = InvoiceFacade.potential_revenue(quantity2)
      
      expect(expected2.length).to eq 2
      expect(expected[0].revenue).to eq 800.0
    end
  end
end