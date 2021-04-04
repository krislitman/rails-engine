class MerchantFacade
  def self.all_merchants(page, per_page)
    Merchant.pagination(page, per_page)
  end

  def self.search(search_term)
    merchant = Merchant.where('name ILIKE ?', "%#{search_term}%").order(:name)
    merchant.first
  end
end