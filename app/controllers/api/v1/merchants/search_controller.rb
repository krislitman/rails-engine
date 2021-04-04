class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchant = MerchantFacade.search(params[:name]) 
    if merchant.nil?
      render json: MerchantSerializer.no_merchant
    else
      render json: MerchantSerializer.new(merchant) 
    end
  end
end