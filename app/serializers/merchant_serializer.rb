class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  def self.no_merchant
    {
      data: {
        
      }
    }
  end

  def self.total_revenue(merchant_data)
    {
      data: {
        id: merchant_data[:merchant].id.to_s,
        type: "merchant_revenue",
        attributes: {
          revenue: merchant_data[:revenue]
        }
      }
    }
  end
end