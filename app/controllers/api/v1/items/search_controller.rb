class Api::V1::Items::SearchController < ApplicationController
  def index
    case
    when params[:name] && params[:min_price] && params[:max_price]
      render json: { message: "Wrong parameters" }, status: 404
    when params[:name] && params[:min_price]
      render json: { message: "Wrong parameters" }, status: 404
    when params[:name] && params[:max_price]
      render json: { message: "Wrong parameters" }, status: 404
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