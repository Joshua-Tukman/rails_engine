require 'date'
FactoryBot.define do
  factory :transaction do
    invoice_id { rand(20) }
    credit_card_number { rand(1000000000) }
    credit_card_expiration_date { Date.new(2021, 02,28).next_year }
    result { "success" }
  end
end