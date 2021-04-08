class ItemFacade
  def self.all_items(page, per_page)
    Item.pagination(page, per_page)
  end
  
  def self.search(search_terms)
    if search_terms.empty?
      return
    elsif search_terms[:min_price] && search_terms[:max_price]
      Item.price_search(search_terms[:min_price], search_terms[:max_price])
    elsif search_terms[:name]
      Item.name_search(search_terms[:name])
    elsif search_terms[:min_price]
      Item.min_search(search_terms[:min_price])
    elsif search_terms[:max_price]
      Item.max_search(search_terms[:max_price])
    end
  end
end
