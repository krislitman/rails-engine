class Api::V1::Merchants::SearchController < ApplicationController
  def index
    if params[:name].blank?
      render json: { data: {} }, status: :bad_request
    else
      merchant = MerchantFacade.search(params[:name])
      if merchant.nil?
        render json: { data: {} }, status: :bad_request if merchant.nil?
      else
        render json: MerchantSerializer.new(merchant)
      end
    end
  end
end
