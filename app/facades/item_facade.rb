class ItemFacade
  def self.all_items(page, per_page)
    Item.pagination(page, per_page)
  end

  def self.search(search_terms)
    case
    when search_terms[:min_price] &&
      search_terms[:max_price]
      price_search(search_terms[:min_price], 
        search_terms[:max_price])
    when search_terms[:name]
      name_search(search_terms[:name])
    when search_terms[:min_price]
      min_search(search_terms[:min_price])
    when search_terms[:max_price]
      max_search(search_terms[:max_price])
    end
  end

  def self.price_search(min_price, max_price)
    Item.find_by_sql(
      "select items.* from items
      where (unit_price >= #{min_price}) AND
      (unit_price <= #{max_price})"
    )
  end

  def self.max_search(max_price)
    Item.where('unit_price <= ?', max_price)
  end

  def self.min_search(min_price)
    Item.where('unit_price >= ?', min_price)
  end

  def self.name_search(search_term)
    Item.find_by_sql(
      "select items.* from items
      where name ILIKE '%#{search_term}%' 
      order by name"
    )
  end
end