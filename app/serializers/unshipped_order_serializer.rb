class UnshippedOrderSerializer
  include FastJsonapi::ObjectSerializer
  attribute :potential_revenue, &:revenue
end
