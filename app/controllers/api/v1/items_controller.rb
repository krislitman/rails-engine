class Api::V1::ItemsController < ApplicationController
  def index
    items = ItemFacade.all_items(params.fetch(:page, 1), params.fetch(:per_page, 20))
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end
end