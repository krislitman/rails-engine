class Api::V1::Items::SearchController < ApplicationController
  def index
    items = ItemFacade.search(params[:name])
    render json: ItemSerializer.new(items)
  end
end