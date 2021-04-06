require 'rails_helper'

RSpec.describe Merchant do
  describe 'Validations' do 
    it { should validate_presence_of :name }
  end
  describe 'Relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end
  describe 'Class Methods' do
    before :each do
      Merchant.destroy_all
      Item.destroy_all
      Invoice.destroy_all
      Transaction.destroy_all
      Customer.destroy_all
      InvoiceItem.destroy_all
    end
    it '#search' do
      merchant = create(:merchant, name: "Cool shop")
      merchant2 = create(:merchant, name: "NOT SWEET")

      term = "cool"

      expect(Merchant.search(term).length).to eq 1
      expect(Merchant.search(term).first.name).to eq(merchant.name)
    end
    it '#by_revenue' do
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
  
      merchant3 = create(:merchant)
      customer3 = create(:customer)
      item9 = create(:item, merchant_id: merchant3.id)
      item10 = create(:item, merchant_id: merchant3.id)
      item11 = create(:item, merchant_id: merchant3.id)
      item12 = create(:item, merchant_id: merchant3.id)
      invoice9 = create(:invoice, customer_id: customer3.id, merchant_id: merchant3.id, status: 'shipped')
      invoice10 = create(:invoice, customer_id: customer3.id, merchant_id: merchant3.id, status: 'shipped')
      invoice11 = create(:invoice, customer_id: customer3.id, merchant_id: merchant3.id, status: 'shipped')
      invoice12 = create(:invoice, customer_id: customer3.id, merchant_id: merchant3.id, status: 'shipped')
      invoice_item9 = create(:invoice_item, item_id: item9.id, invoice_id: invoice9.id, quantity: 10, unit_price: 20.00)
      invoice_item10 = create(:invoice_item, item_id: item10.id, invoice_id: invoice10.id, quantity: 10, unit_price: 20.00)
      invoice_item11 = create(:invoice_item, item_id: item11.id, invoice_id: invoice11.id, quantity: 10, unit_price: 20.00)
      invoice_item12 = create(:invoice_item, item_id: item12.id, invoice_id: invoice12.id, quantity: 10, unit_price: 20.00)
      transaction9 = create(:transaction, invoice_id: invoice9.id, result: "success")
      transaction10 = create(:transaction, invoice_id: invoice10.id, result: "success")
      transaction11 = create(:transaction, invoice_id: invoice11.id, result: "success")
      transaction12 = create(:transaction, invoice_id: invoice12.id, result: "success")

      expected = Merchant.by_revenue(2)

      expect(expected.length).to eq 2
    end
  end
  describe 'Instance Methods' do
    before :each do 
      Merchant.destroy_all
      Item.destroy_all
      Invoice.destroy_all
      Transaction.destroy_all
      Customer.destroy_all
      InvoiceItem.destroy_all
    end
    it '#total_revenue' do
      merchant3 = create(:merchant)
      customer3 = create(:customer)
      item9 = create(:item, merchant_id: merchant3.id)
      item10 = create(:item, merchant_id: merchant3.id)
      item11 = create(:item, merchant_id: merchant3.id)
      item12 = create(:item, merchant_id: merchant3.id)
      invoice9 = create(:invoice, customer_id: customer3.id, merchant_id: merchant3.id, status: 'shipped')
      invoice10 = create(:invoice, customer_id: customer3.id, merchant_id: merchant3.id, status: 'shipped')
      invoice11 = create(:invoice, customer_id: customer3.id, merchant_id: merchant3.id, status: 'shipped')
      invoice12 = create(:invoice, customer_id: customer3.id, merchant_id: merchant3.id, status: 'shipped')
      invoice_item9 = create(:invoice_item, item_id: item9.id, invoice_id: invoice9.id, quantity: 10, unit_price: 20.00)
      invoice_item10 = create(:invoice_item, item_id: item10.id, invoice_id: invoice10.id, quantity: 10, unit_price: 20.00)
      invoice_item11 = create(:invoice_item, item_id: item11.id, invoice_id: invoice11.id, quantity: 10, unit_price: 20.00)
      invoice_item12 = create(:invoice_item, item_id: item12.id, invoice_id: invoice12.id, quantity: 10, unit_price: 20.00)
      transaction9 = create(:transaction, invoice_id: invoice9.id, result: "success")
      transaction10 = create(:transaction, invoice_id: invoice10.id, result: "success")
      transaction11 = create(:transaction, invoice_id: invoice11.id, result: "success")
      transaction12 = create(:transaction, invoice_id: invoice12.id, result: "success")

      expected = merchant3.total_revenue
      
      expect(expected).to eq 800.0
    end
  end
end