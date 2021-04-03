class MerchantFacade
  def self.all_merchants(page, per_page)
    Merchant.pagination(page, per_page)
  end
end