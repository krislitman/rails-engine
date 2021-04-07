class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    if params[:quantity].to_i <= 0 || params[:quantity].nil?
      render json: { error: "Invalid quantity" }, status: :bad_request 
    else
      merchants = MerchantFacade.items_sold(params[:quantity])
      # require 'pry'; binding.pry
      render json: ItemsSoldSerializer.new(merchants)
    end
  end
end