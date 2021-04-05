class Api::V1::Revenue::MerchantController < ApplicationController
  def index
    if params[:quantity].nil?
      render json: { error: 'Missing parameters' }, status: 400
    else
      merchants = MerchantFacade.merchants_by_revenue(params[:quantity])
      render json: MerchantSerializer.merchants_by_revenue(merchants)
    end
  end

  def show
    merchant_data = MerchantFacade.total_revenue(Merchant.find(params[:id]))
    render json: MerchantSerializer.total_revenue(merchant_data)
  end
end
