require 'rails_helper'

RSpec.describe "Returns one item" do
  before :each do
    Item.destroy_all
    @items = create_list(:item, 20)
  end
  describe 'Item API' do
    it 'Returns a single item by id' do
      get "/api/v1/items/#{@items.first.id}"
      
      @found_item = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      expect(response.status).to eq 200
      expect(@found_item).to be_a Hash
    end
    it 'Returns error if invalid id' do
      get "/api/v1/items/0"

      expect(response).not_to be_successful
      expect(response.status).to eq 404
    end
  end
end