FactoryBot.define do
  factory :invoice do
    status { "Shipped" }
    customer
    merchant
  end
end