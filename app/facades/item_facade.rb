class ItemFacade
  def self.all_items(page, per_page)
    Item.pagination(page, per_page)
  end
end