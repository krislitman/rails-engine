class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name 
  attribute :revenue do |object|
    object.total_revenue
  end
  def self.single_merchant_revenue(merchant_data)
    {
      data: {
        id: merchant_data[:merchant].id.to_s,
        type: 'merchant_revenue',
        attributes: {
          revenue: merchant_data[:revenue]
        }
      }
    }
  end
end

