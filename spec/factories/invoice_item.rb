FactoryBot.define do
  factory :invoice_item do
    sequence(:quantity) { |n| "Quantity #{n}" }
    sequence(:unit_price) { |n| "Unit price #{n}" }
    invoice
    item
  end
end