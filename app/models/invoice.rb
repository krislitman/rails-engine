class Invoice < ApplicationRecord
  validates :status, presence: true

  belongs_to :customer
  belongs_to :merchant
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  def self.potential_revenue(quantity)
    joins(:invoice_items, :transactions)
    .select('invoices.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
    .merge(Transaction.successful)
    .where('invoices.status != ?', 'shipped')
    .group(:id).order('revenue DESC')
    .limit(quantity)
  end
end
