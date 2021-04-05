class MerchantFacade
  def self.merchants_by_revenue(quantity)
    Merchant.by_revenue(quantity)
  end

  def self.total_revenue(merchant)
    { revenue: merchant.total_revenue,
      merchant: merchant }
  end

  def self.all_merchants(page, per_page)
    if page.to_i <= 1 
      Merchant.pagination(1, per_page)
    else
      Merchant.pagination(page, per_page)
    end
  end

  def self.search(search_term)
    merchant = Merchant.search(search_term)
    merchant.first
  end
end
