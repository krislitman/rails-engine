require 'rails_helper'

RSpec.describe 'Endpoint to return variable number of merchants' do
  describe 'Ranked by total number of items sold' do
    it 'Errors out when quantity is not greater than 0' do
      get '/api/v1/merchants/most_items?quantity=0'

      expect(response).not_to be_successful
      expect(response.status).to eq 400
    end
      it 'Returns 5 as default when no quantity is given'
      merchant1 = create(:merchant)
      items1 = create_list(:item, 10, merchant_id: merchant1.id)
      
      merchant2 = create(:merchant)
      items2 = create_list(:item, 20, merchant_id: merchant2.id)
      
      merchant3 = create(:merchant)
      items3 = create_list(:item, 30, merchant_id: merchant3.id)

      merchant4 = create(:merchant)
      items4 = create_list(:item, 40, merchant_id: merchant4.id)
      
      merchant5 = create(:merchant)
      items5 = create_list(:item, 50, merchant_id: merchant5.id)

      merchant6 = create(:merchant)
      items6 = create_list(:item, 60, merchant_id: merchant6.id)
      it 'Returns more than 5'
  end
end