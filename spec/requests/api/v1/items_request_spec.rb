require 'rails_helper'

RSpec.describe "Items API" do
  it "can get an item" do
    merchant = create(:merchant) 
    item = build(:item)
    item.merchant_id = merchant.id 
    item.save
    
    get "/api/v1/items/#{item.id}"
    
    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:data][:type]).to eq('item')
  end
  
  it 'can send a list of all items' do
    merchant = create(:merchant) 
    items = build_list(:item, 10)
    items.each do |item|
      item.merchant_id = merchant.id
      item.save
    end
    
    get '/api/v1/items'

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    json[:data].each do |item|
        expect(item[:type]).to eq("item")
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes]).to have_key(:unit_price)
    end
  end
  it 'can create and item' do
    merchant = create(:merchant)
    headers = { "CONTENT_TYPE" => "application/json" }
    item_params = { name: 'Climbing Rope', description: 'Will never let you down', unit_price: 320.25, merchant_id: merchant.id }
    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)
   
    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:attributes][:unit_price]).to eq(320.25)
    item = Item.last
    
    expect(item.name).to eq('Climbing Rope')
    expect(item.description).to eq('Will never let you down')
  end 
  it 'can delete an item' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    
    expect(Item.count).to eq(1)

    #delete "/api/v1/items/#{item.id}"

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)
    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
  it "can update an existing item" do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id
    previous_name = Item.last.name
    item_params = { name: "Carabiner", description: "Rock solid" }
    headers = {"CONTENT_TYPE" => "application/json"}

    put "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item_params)
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Carabiner")
    expect(item.description).to eq("Rock solid")
  end  
end 