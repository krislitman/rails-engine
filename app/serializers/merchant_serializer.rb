class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  def self.no_merchant
    {
      data: {
        
      }
    }
  end
end