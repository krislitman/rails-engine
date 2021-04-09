require 'rails_helper'

RSpec.describe Transaction do
  describe 'Validations' do 
    it { should validate_presence_of :credit_card_number }
    it { should validate_presence_of :credit_card_expiration_date }
    it { should validate_presence_of :result }
  end
  describe 'Relationships' do
    it { should belong_to :invoice } 
  end
  describe 'Class Methods' do
    it '#successful' do
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
      transaction1 = create(:transaction, invoice_id: invoice1.id, result: 'success')

      merchant2 = create(:merchant)
      item2 = create(:item, merchant_id: merchant2.id)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
      invoice_items2 = create_list(:invoice_item, 20, item_id: item2.id, invoice_id: invoice2.id, quantity: 20)
      transaction2 = create(:transaction, invoice_id: invoice2.id, result: 'in progress')

      expected = Transaction.successful

      expect(expected.length).to eq 1
      expect(expected[0].id).to eq(transaction1.id)
    end
  end
end