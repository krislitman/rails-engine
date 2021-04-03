FactoryBot.define do
  factory :customer do
    sequence(:first_name) { |n| "First name #{n}" }
    sequence(:last_name) { |n| "Last name #{n}" }
  end
end