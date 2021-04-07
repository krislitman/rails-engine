require 'rails_helper'

RSpec.describe 'Report of orders which have not shipped' do
  describe 'Ranked by total revenue DESC' do
    it 'Should error out if integer is not greater than 0' do
      get '/api/v1/revenue/unshipped?quantity=0'

      expect(response).not_to be_successful
      expect(response.status).to eq 400
    end
  end
end