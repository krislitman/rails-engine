class Api::V1::Revenue::OrdersController < ApplicationController
  def index
    if params[:quantity].to_i <= 0
      render json: { error: 'Invalid quantity' }, status: :bad_request
    else
    end
  end
end