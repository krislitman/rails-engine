class Api::V1::Items::SearchController < ApplicationController
  def index
    case 
    when !params[:name] && !params[:min_price] && !params[:max_price]
      render json: { message: 'Incorrect parameters' }, status: :bad_request
    when params[:name].blank? && params[:min_price].nil? && params[:max_price].nil?
      render json: { message: 'Incorrect parameters' }, status: :bad_request
    when params[:name] && ( params[:min_price] || params[:max_price] )
      render json: { message: 'Incorrect parameters' }, status: :bad_request
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
