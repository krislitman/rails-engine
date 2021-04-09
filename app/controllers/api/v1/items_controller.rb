class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: %i[show update destroy]
  def index
    if params[:per_page] && params[:per_page].to_i <= 0
      render json: { error: 'Invalid parameters' }, status: :bad_request
    else
      items = ItemFacade.all_items(params.fetch(:page, 1), params.fetch(:per_page, 20))
      render json: ItemSerializer.new(items)
    end
  end

  def show
    render json: ItemSerializer.new(@item)
  end

  def create
    item = Item.create!(item_params)
    render json: ItemSerializer.new(item), status: :created
  end

  def update
    @item.update!(item_params)
    render json: ItemSerializer.new(@item)
  end

  def destroy
    Invoice.destroy(@item.destroy_invoice)
    render json: Item.delete(@item)
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
