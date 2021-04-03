class MerchantFacade
  def self.all_merchants(page, per_page)
    merchants = Merchant.pagination(page, per_page)
  end
end