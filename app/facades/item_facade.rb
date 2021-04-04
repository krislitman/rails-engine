class ItemFacade
  def self.all_items(page, per_page)
    Item.pagination(page, per_page)
  end

  def self.search(search_term)
    Item.find_by_sql(
      "select items.* from items
      where name ILIKE '%#{search_term}%' OR 
      description ILIKE '%#{search_term}%'
      order by name"
    )
  end
end