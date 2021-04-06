require 'rails_helper'

RSpec.describe 'Item API' do
  it "Item can be destroyed" do
    Merchant.destroy_all
    Item.destroy_all
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"
    
    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
  it 'Returns error if id not found' do
    
    delete "/api/v1/items/0"

    expect(response).not_to be_successful
    expect(response.status).to eq 404
  end
  it 'Destroys any invoice it belongs to if it is the only item' do
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

    delete "/api/v1/items/#{item1.id}"

    deleted = Invoice.where(id: invoice1.id).first

    expect(deleted).to be_nil
    expect(Invoice.find(invoice2.id)).not_to be_nil
  end
end