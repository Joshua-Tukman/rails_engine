class Api::V1::Items::ItemSearchController < ApplicationController
  def index   
    search = "%" + params[:name].downcase + "%"
    items = Item.find_names(search)
    render json: ItemSerializer.new(items)
  end

  def show
    search = "%" + params[:name].downcase + "%"
    item = Item.find_one(search)
    render json: ItemSerializer.new(item)
  end
end 