require 'rails_helper'

RSpec.describe ItemFacade do
  describe 'Class Methods' do
    it '#all_items' do
      Item.destroy_all
      create_list(:item, 30)

      page1 = "1"
      page2 = "2"
      per_page = "20"

      expected = ItemFacade.all_items(page1, per_page)
      expected2 = ItemFacade.all_items(page2, per_page)
      
      expect(expected.length).to eq 20
      expect(expected2.length).to eq 10
    end
    it '#search' do
      Merchant.destroy_all
      Item.destroy_all
      merchant = create(:merchant)
      item1 = create(:item, unit_price: 2.00, merchant_id: merchant.id)
      item2 = create(:item, unit_price: 6.00, merchant_id: merchant.id)
      item3 = create(:item, unit_price: 20.99, merchant_id: merchant.id)
      item4 = create(:item, unit_price: 3.50, merchant_id: merchant.id)

      min_price = { min_price: "7" }
      max_price = { max_price: "10" }
      name = { name: "#{item2.name}" }

      expected = ItemFacade.search(min_price)
      expected2 = ItemFacade.search(max_price)
      expected3 = ItemFacade.search(name)
      
      expect(expected.length).to eq 1
      expect(expected2.length).to eq 3
      expect(expected3[0].name).to eq(item2.name)
    end
  end
end