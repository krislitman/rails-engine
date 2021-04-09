class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    if params[:quantity].blank?
      render json: { error: 'Invalid quantity' }, status: :bad_request
    elsif params[:quantity].to_i <= 0 && params[:quantity].present?
      render json: { error: 'Invalid quantity' }, status: :bad_request
    else
      merchants = MerchantFacade.items_sold(params[:quantity])
      render json: ItemsSoldSerializer.new(merchants)
    end
  end
end
