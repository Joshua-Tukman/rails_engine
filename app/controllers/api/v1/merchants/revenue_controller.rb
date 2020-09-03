class Api::V1::Merchants::RevenueController < ApplicationController
  def most_revenue
    limit = params[:quantity]
    merchants = Merchant.most_money(limit)
    format(merchants)
  end

  def most_items
    limit = params[:quantity]
    merchants = Merchant.most_items(limit)
    format(merchants)
  end

  private

  def format(merchants)
    render json: MerchantSerializer.new(merchants)
  end
end 