require 'rails_helper'

RSpec.describe "Merchant API" do
  it "can get a merchant" do 
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:id]).to eq("#{id}")
  end
  it "can return a list of merchants" do
    create_list(:merchant, 10)

    get "/api/v1/merchants" 

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    
    expect(Merchant.all.count).to eq(10)
    json[:data].each do |merchant|
        expect(merchant[:type]).to eq("merchant")
        expect(merchant[:attributes]).to have_key(:name)
    end
  end
  it "can create a merchant" do
    merchant_params = { name: "Jerry Garcia" }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/merchants", headers: headers, params: JSON.generate(merchant_params)
    
    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:data][:type]).to eq('merchant')
    expect(json[:data][:attributes][:name]).to eq('Jerry Garcia')
  end
  it "can delete a merchant" do
    id = create(:merchant).id
    
    expect(Merchant.count).to eq(1)
    expect{delete "/api/v1/merchants/#{id}"}.to change(Merchant, :count).by(-1)
    expect(Merchant.count).to eq(0)
  end
  it "can update a merchant" do
    id = create(:merchant).id

    expect(Merchant.last.id).to eq(id)
    previous_name = Merchant.last.name
    merchant_params = { name: "Josh" }
    headers = {"CONTENT_TYPE" => "application/json"}
    patch "/api/v1/merchants/#{id}", headers: headers, params: JSON.generate(merchant_params)

    expect(response).to be_successful
  
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:data][:attributes][:name]).to eq("Josh")
  end 
end 