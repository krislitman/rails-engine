class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  scope :search, lambda { |search_term|
                   where('name ILIKE ?', "%#{search_term}%")
                     .order(:name)
                 }

  def total_revenue
    expected = invoice_items
               .joins(:transactions)
               .where('transactions.result = ?', 'success')
               .where('invoices.status = ?', 'shipped')
               .select('sum(unit_price * quantity) as total_revenue')
    expected[0].total_revenue
  end

  def self.by_revenue(quantity)
    find_by_sql(
      "select merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue from merchants
      inner join items 
      on items.merchant_id = merchants.id 
      inner join invoice_items
      on invoice_items.item_id = items.id
      inner join invoices
      on invoices.id = invoice_items.invoice_id
      inner join transactions
      on transactions.invoice_id = invoices.id
      where transactions.result = 'success' AND invoices.status = 'shipped'
      group by merchants.id
      order by total_revenue DESC
      limit #{quantity}"
    )
  end
end
