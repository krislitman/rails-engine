class MerchantNameRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  attribute :revenue, &:total_revenue
end
