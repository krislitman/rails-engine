class MerchantFacade
  def self.total_revenue(merchant)
    expected = { revenue: merchant.total_revenue,
      merchant: merchant }
  end
  
  def self.all_merchants(page, per_page)
    Merchant.pagination(page, per_page)
  end

  def self.search(search_term)
    merchant = Merchant.search(search_term)
    merchant.first
  end
end