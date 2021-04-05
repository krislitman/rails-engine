class Api::V1::Revenue::MerchantController < ApplicationController
  def show
    merchant_data = MerchantFacade.total_revenue(Merchant.find(params[:id]))
    render json: MerchantSerializer.total_revenue(merchant_data)
  end
end
