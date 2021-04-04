class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchant = MerchantFacade.search(params[:name])
    render json: MerchantSerializer.new(merchant)
  end
end