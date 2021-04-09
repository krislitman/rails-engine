require 'rails_helper'

RSpec.describe Item do
  describe 'Validations' do 
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end
  describe 'Relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items)}
  end
  describe 'Instance Methods' do
    it '#destroy_invoice' do
      Merchant.destroy_all
      Customer.destroy_all
      Invoice.destroy_all
      InvoiceItem.destroy_all
      Item.destroy_all
      merchant = create(:merchant)
      customer = create(:customer)
      item1 = create(:item, merchant_id: merchant.id)
      invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)

      item2 = create(:item, merchant_id: merchant.id)
      item3 = create(:item, merchant_id: merchant.id)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id)
      invoice_item3 = create(:invoice_item, item_id: item3.id, invoice_id: invoice2.id)

      expected = invoice1.id

      expect(item1.destroy_invoice[0]).to eq(invoice1.id)
      expect(item2.destroy_invoice).to eq([])
      expect(item3.destroy_invoice).to eq([])
    end
  end
  describe 'Class Methods' do
    it '#pagination' do
      Item.destroy_all
      items = create_list(:item, 30)

      expected = Item.pagination("1", "20")
      expected2 = Item.pagination("2", "20")

      expect(expected.length).to eq 20
      expect(expected2.length).to eq 10
    end
    it '#price_search' do
      Merchant.destroy_all
      Item.destroy_all
      merchant = create(:merchant)
      item1 = create(:item, unit_price: 2.00, merchant_id: merchant.id)
      item2 = create(:item, unit_price: 6.00, merchant_id: merchant.id)
      item3 = create(:item, unit_price: 20.99, merchant_id: merchant.id)
      item4 = create(:item, unit_price: 3.50, merchant_id: merchant.id)
      item4 = create(:item, unit_price: 30.00, merchant_id: merchant.id)
      min = "2.25"
      max = "10"
      expected = Item.price_search(min, max)
      
      expect(expected.length).to eq 2
    end
    it '#name_search' do
      Merchant.destroy_all
      Item.destroy_all
      merchant = create(:merchant)
      item1 = create(:item, merchant_id: merchant.id)
      item2 = create(:item, merchant_id: merchant.id)
      item3 = create(:item, merchant_id: merchant.id)

      expect(Item.name_search(item1.name)[0].name).to eq(item1.name)
      expect(Item.name_search(item2.name)[0].name).to eq(item2.name)
      expect(Item.name_search(item3.name)[0].name).to eq(item3.name)
    end
    it '#max_search' do
      Merchant.destroy_all
      Item.destroy_all
      merchant = create(:merchant)
      item1 = create(:item, unit_price: 2.00, merchant_id: merchant.id)
      item2 = create(:item, unit_price: 6.00, merchant_id: merchant.id)
      item3 = create(:item, unit_price: 20.99, merchant_id: merchant.id)
      item4 = create(:item, unit_price: 3.50, merchant_id: merchant.id)
      item4 = create(:item, unit_price: 30.00, merchant_id: merchant.id)
      max = "10"
      expected = Item.max_search(max)
      
      expect(expected.length).to eq 3
    end
    it '#min_search' do
      Merchant.destroy_all
      Item.destroy_all
      merchant = create(:merchant)
      item1 = create(:item, unit_price: 2.00, merchant_id: merchant.id)
      item2 = create(:item, unit_price: 6.00, merchant_id: merchant.id)
      item3 = create(:item, unit_price: 20.99, merchant_id: merchant.id)
      item4 = create(:item, unit_price: 3.50, merchant_id: merchant.id)
      item4 = create(:item, unit_price: 30.00, merchant_id: merchant.id)
      min = "2.25"
      expected = Item.min_search(min)
      
      expect(expected.length).to eq 4
    end
  end
end