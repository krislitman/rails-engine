class Api::V1::Items::SearchController < ApplicationController
  def index
    if params[:name] && (params[:min_price] || params[:max_price])
      render json: { message: 'Wrong parameters' }, status: :not_found
      # bad_request not not_found
    elsif params[:name] && params[:min_price]
      render json: { message: 'Wrong parameters' }, status: :not_found
    elsif params[:name] && params[:max_price]
      render json: { message: 'Wrong parameters' }, status: :not_found
    else
      items = ItemFacade.search(search_params)
      render json: ItemSerializer.new(items)
    end
  end

  private

  def search_params
    params.permit(:name, :min_price, :max_price)
  end
end
