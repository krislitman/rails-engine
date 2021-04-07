class Api::V1::Revenue::OrdersController < ApplicationController
  def index
    if params[:quantity].to_i <= 0 && !params[:quantity].nil?
      render json: { error: 'Invalid quantity' }, status: :bad_request
    else
      orders = InvoiceFacade.potential_revenue(params[:quantity])
      render json: UnshippedOrderSerializer.new(orders)
    end
  end
end