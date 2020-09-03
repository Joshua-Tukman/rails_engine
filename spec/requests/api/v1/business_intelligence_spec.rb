require 'rails_helper'

RSpec.describe "Business Intelligence" do
  before(:each) do
    @merchant1 = create(:merchant, name: "Bob")
    @customer = create(:customer)
    @items = create_list(:item, 2, merchant_id: @merchant1.id, unit_price: 10.00)
    @invoice = create(:invoice, merchant_id: @merchant1.id, customer_id: @customer.id)
    @invoice_items = create_list(:invoice_item, 2, item_id: @items.first.id, invoice_id: @invoice.id)
    @transaction = create(:transaction, invoice_id: @invoice.id)

    @merchant2 = create(:merchant, name: "Sue")
    @items2 = create_list(:item, 2, merchant_id: @merchant2.id, unit_price: 20.00)
    @invoice2 = create(:invoice, merchant_id: @merchant2.id, customer_id: @customer.id)
    @invoice_items2 = create_list(:invoice_item, 3, item_id: @items2.first.id, invoice_id: @invoice2.id, unit_price: 20.00)
    @transaction2 = create(:transaction, invoice_id: @invoice2.id)

    @merchant3 = create(:merchant, name: "Josh")
    @items3 = create_list(:item, 2, merchant_id: @merchant3.id, unit_price: 30.00)
    @invoice3 = create(:invoice, merchant_id: @merchant3.id, customer_id: @customer.id)
    @invoice_items3 = create_list(:invoice_item, 4, item_id: @items3.first.id, invoice_id: @invoice3.id, unit_price: 30.00)
    @transaction3 = create(:transaction, invoice_id: @invoice3.id)

    @merchant4 = create(:merchant, name: "Ed")
    @items4 = create_list(:item, 2, merchant_id: @merchant4.id, unit_price: 40.00)
    @invoice4 = create(:invoice, merchant_id: @merchant4.id, customer_id: @customer.id)
    @invoice_items4 = create_list(:invoice_item, 5, item_id: @items4.first.id, invoice_id: @invoice4.id, unit_price: 40.00)
    @transaction4 = create(:transaction, invoice_id: @invoice4.id)

    @merchant5 = create(:merchant, name: "Larry")
    @items5 = create_list(:item, 2, merchant_id: @merchant5.id, unit_price: 50.00)
    @invoice5 = create(:invoice, merchant_id: @merchant5.id, customer_id: @customer.id)
    @invoice_items5 = create_list(:invoice_item, 6, item_id: @items5.first.id, invoice_id: @invoice5.id, unit_price: 50.00)
    @transaction5 = create(:transaction, invoice_id: @invoice5.id)
  end 
  it "can return the merchant with the most revenue" do
       
    get "/api/v1/merchants/most_revenue?quantity=5"
    Merchant.revenue(@merchant1.id)
    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    
    expect(json[:data].first[:attributes][:name]).to eq("Larry")
    expect(json[:data][1][:attributes][:name]).to eq("Ed")
    expect(json[:data][2][:attributes][:name]).to eq("Josh")
    expect(json[:data][3][:attributes][:name]).to eq("Sue")
    expect(json[:data][4][:attributes][:name]).to eq("Bob")
  end
  it "can return the merchant who sold the most items" do

    get "/api/v1/merchants/most_items?quantity=8"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].first[:attributes][:name]).to eq("Larry")
    expect(json[:data][1][:attributes][:name]).to eq("Ed")
    expect(json[:data][2][:attributes][:name]).to eq("Josh")
    expect(json[:data][3][:attributes][:name]).to eq("Sue")
    expect(json[:data][4][:attributes][:name]).to eq("Bob")
  end 
  
end 