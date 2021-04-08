class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  scope :price_search, lambda { |min_price, max_price|
    find_by_sql(
      "select items.* from items
      where (unit_price >= #{min_price}) AND
      (unit_price <= #{max_price})"
    )
  }

  scope :name_search, lambda { |search_term|
    find_by_sql(
      "select items.* from items
      where name ILIKE '%#{search_term}%'
      order by name"
    )
  }
  
  scope :max_search, lambda { |max_price|
    where('unit_price <= ?', max_price)
  }

  scope :min_search, lambda { |max_price|
    where('unit_price >= ?', max_price)
  }

  def destroy_invoice
    expected = invoices.joins(:items)
    .select("invoices.*, count(items.*)")
    .group("invoices.id")
    .having("count(items.*) = 1").pluck(:id)
  end
end
