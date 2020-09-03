FactoryBot.define do
  factory :invoice do
    merchant_id { rand(20) }
    customer_id { rand(30) }
    status { "shipped" }
  end
end