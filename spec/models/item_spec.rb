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
end