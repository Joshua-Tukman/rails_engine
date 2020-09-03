class Api::V1::Merchants::MerchantSearchController < ApplicationController
  def index
    search = "%" + params[:name].downcase + "%"
    merchants = Merchant.find_names(search)
    render json: MerchantSerializer.new(merchants)
  end
  
  def show
    search = "%" + params[:name].downcase + "%"
    merchant = Merchant.find_one(search)
    render json: MerchantSerializer.new(merchant)
  end 
end 