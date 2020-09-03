require 'rails_helper'

RSpec.describe "Search endpoints" do
  describe "Merchant search" do
    it "can find a list of merchants that contain a fragment, case insensitive" do
      create(:merchant, name: "JOn") 
      create(:merchant, name: "Joe") 
      create(:merchant, name: "joseph") 
      create(:merchant, name: "Bob") 
      create(:merchant, name: "Banjo") 
      create(:merchant, name: "Suzy") 
      create(:merchant, name: "Frank")
      
      search_params = { name: "JO" }

      get '/api/v1/merchants/find_all', params: search_params

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data]).to be_an(Array)
      expect(json[:data].length).to eq(4)

      json[:data].each do |merchant|
        expect(merchant[:attributes].keys).to include(:name)
      end
      expect(json[:data].first[:attributes][:name]).to eq("JOn")
    end
    it "can find a merchant that contain a fragment, case insensitive" do
      create(:merchant, name: "Jon") 
      create(:merchant, name: "BUz") 
      create(:merchant, name: "joseph") 
      create(:merchant, name: "Bob") 
      create(:merchant, name: "Banjo") 
      create(:merchant, name: "SuZy") 
      create(:merchant, name: "Frank")

      
      search_params = { name: "uz" }

      get '/api/v1/merchants/find', params: search_params
      
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(json[:data]).to be_a(Hash)
      expect(json[:data][:attributes].values).to include("BUz")
      expect(json[:data][:attributes].values).to_not include("SuZy")
    end
  end 
  describe "Items search" do
    it "can find a list of items that contain a fragment, case insensitive" do
      id = create(:merchant).id
      create(:item, name: "OCky", merchant_id: id)
      create(:item, name: "shoe", merchant_id: id)
      create(:item, name: "bLOck", merchant_id: id)
      create(:item, name: "frocK", merchant_id: id)

      search_params = { name: "oCk"}
      get '/api/v1/items/find_all', params: search_params

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(json[:data].first[:type]).to eq("item")
      expect(json[:data]).to be_an(Array)
    end
    it "can find an item that contain a fragment, case insensitive" do
      id = create(:merchant).id
      create(:item, name: "OCky", merchant_id: id)
      create(:item, name: "shoe", merchant_id: id)
      create(:item, name: "bLOck", merchant_id: id)
      create(:item, name: "frocK", merchant_id: id)
      
      search_params = { name: 'oCk' }

      get '/api/v1/items/find', params: search_params

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(json[:data]).to be_a(Hash)
      expect(json[:data][:attributes].values).to include("OCky")
      expect(json[:data][:attributes].values).to_not include("bLOck")
    end

  end
end 