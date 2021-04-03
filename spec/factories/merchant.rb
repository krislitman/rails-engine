FactoryBot.define do
  factory :merchant do
    sequence(:name) { |n| "#{Faker::Games::SuperMario.character} #{n}" }
  end
end