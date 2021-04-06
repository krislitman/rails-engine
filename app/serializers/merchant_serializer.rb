class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  def self.total_revenue(merchant_data)
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

  def self.merchants_by_revenue(merchants)
    {
      data: merchants.map do |merchant|
        {
          id: merchant.id.to_s,
          type: 'merchant_name_revenue',
          attributes: {
            name: merchant.name,
            revenue: merchant.total_revenue
          }
        }
      end
    }
  end
end
