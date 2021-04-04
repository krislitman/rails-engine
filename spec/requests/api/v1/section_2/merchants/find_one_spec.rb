require 'rails_helper'

RSpec.describe 'Find one Merchant API' do
  it 'Can find one merchant' do
    Merchant.destroy_all
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"

    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq 200
    expect(expected[:data][:attributes][:name]).to eq(merchant.name)
    expect(expected.length).to eq 1
    expect(expected).to be_a Hash
  end
  it 'Can find one merchant with a bunch of merchants' do
    Merchant.destroy_all
    merchant = create_list(:merchant, 30)
    merchant2 = create(:merchant, name: "little esty shop")

    get "/api/v1/merchants/find?name=esty"

    expected = JSON.parse(response.body, symbolize_names: true)

    expect(expected[:data][:attributes][:name]).to eq(merchant2.name)
  end
  it 'Returns error when match does not happen' do
    Merchant.destroy_all
    merchant = create_list(:merchant, 30)
    merchant2 = create(:merchant, name: "little esty shop")

    get "/api/v1/merchants/find?name=NOMATCH"
    expected = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 200
    expect(expected).to have_key(:data)
  end
end