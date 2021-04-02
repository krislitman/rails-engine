FactoryBot.define do
  factory :transaction do
    sequence(:credit_card_number) { |n| "Credit card number #{n}" }
    sequence(:credit_card_expiration_date) { |n| "Credit card expiration date #{n}" }
    result { "success" }
    invoice
  end
end