class Api::V1::Revenue::MerchantController < ApplicationController
  def index
    if params[:quantity].nil? || params[:quantity].to_i <= 0
      render json: { error: 'Invalid parameters' }, status: :bad_request
    else
      merchants = MerchantFacade.merchants_by_revenue(params[:quantity])
      render json: MerchantNameRevenueSerializer.new(merchants)
    end
  end

  def show
    merchant_data = MerchantFacade.total_revenue(Merchant.find(params[:id]))
    render json: MerchantRevenueSerializer.single_merchant_revenue(merchant_data)
  end
end
