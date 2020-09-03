FactoryBot.define do
  factory :invoice_item do
    item_id { rand(200) }
    invoice_id { rand(100) }
    quantity { 1 }
    unit_price { 10.00 }
  end
end