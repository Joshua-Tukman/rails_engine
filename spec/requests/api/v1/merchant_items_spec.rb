require 'rails_helper'

RSpec.describe "Merchant Items request" do
  it "can get a list of all items belonging to merchant" do 
    id = create(:merchant).id
    create_list(:item, 30, merchant_id: id)

    get "/api/v1/merchants/#{id}/items" 
    expect(response).to be_successful
    expect(Item.count).to eq(30)
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].first[:type]).to eq('item')
    expect(json[:data].length).to eq(30)
    expect(json[:data].first[:attributes]).to have_key(:name)
    expect(json[:data].first[:attributes]).to have_key(:description)
    expect(json[:data].first[:attributes]).to have_key(:unit_price)
  end
  it "can get a merchant that is associated with an item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    
    expect(json[:data][:id]).to eq("#{merchant.id}")
    expect(json[:data][:attributes][:name]).to eq(merchant.name)
  end  
end 