class Api::V1::MerchantItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:merchant_id])
    render json: ItemSerializer.new(merchant.items)
  end

  def show
    merchant = Item.find(params[:item_id]).merchant
    render json: MerchantSerializer.new(merchant)
  end
end 