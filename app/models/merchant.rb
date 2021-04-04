class Merchant < ApplicationRecord
  validates :name, presence: true
  
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices

  scope :search, -> (search_term) { 
    where('name ILIKE ?', "%#{search_term}%")
    .order(:name) }

  def total_revenue
    expected = invoice_items
    .select('sum(unit_price * quantity) as total_revenue')
    expected[0].total_revenue
  end
end