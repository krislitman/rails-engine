class UnshippedOrderSerializer
  include FastJsonapi::ObjectSerializer
  attribute :potential_revenue do |object|
    object.revenue
  end
end