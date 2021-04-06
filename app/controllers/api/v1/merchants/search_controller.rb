class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchant = MerchantFacade.search(params[:name])
    if merchant.nil?
      render json: { data: {}, status: :bad_request }
    else
      render json: MerchantSerializer.new(merchant)
    end
  end
end
